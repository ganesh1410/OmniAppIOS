//
//  OMPermissionsManager.swift
//  OMNI
//
//  Created by Chandrachudh on 05/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit
import UserNotifications
import Photos
import Contacts


/**
 The enum for different permissions used in the app
 */
enum PermissionType {
    case pushNotification
    case photos
    case camera
    case location
    case contacts
    case none
}

/**
 The enum to indicate the different device permission status in app
 */
enum PermissionStatus {
    case denied
    case justDenied
    case granted
    case notDetermined
}

typealias PermissionStatusHandler = (PermissionStatus, String) -> Void

/**
 The manager class that deals with the device permissions for the app.
 */
class OMPermissionsManager: NSObject {
    
    private var shouldShowPushnotificationPermission = false
    fileprivate var locationPermissionsHandler:PermissionStatusHandler?
    fileprivate let locationManager:CLLocationManager = CLLocationManager()

    /**
    Shared instance for the singleton OMPermissionsManager
     */
    class var sharedInstance: OMPermissionsManager {
        struct Static {
            static let instance = OMPermissionsManager()
        }
        
        Static.instance.checkForPushNotificationPermission()
        return Static.instance
    }
    
    /**
     Fetch all access permissions that still needs to be granted
     
     - returns: [PermissionType], an array of the values from enum PermissionType
     */
    func getListAllPendingPermissions() -> [PermissionType] {
        
        var permissionsArray = [PermissionType]()
        
        if shouldShowPushnotificationPermission {
            permissionsArray.append(.pushNotification)
        }
        
        
        
        return permissionsArray
    }
    
    /**
     Checks if push notifications permission is granted or not and save the data in the local variable ```shouldShowPushnotificationPermission```
     */
    private func checkForPushNotificationPermission() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
                if settings.authorizationStatus != .authorized {
                    // Notification permission was not already granted
                    self.shouldShowPushnotificationPermission = true
                }
            })
        } else {
            // Fallback on earlier versions
            if UIApplication.shared.isRegisteredForRemoteNotifications == false {
                shouldShowPushnotificationPermission = true
            }
        }
    }
    
    /**
     Request access for Push Notification to the user
     
     - parameter onCompletion: The completion handler for all scenarios. Returns tuple (permissionStatus, message) of types (PermissionStatus, String)
     */
    func getPushNotificationPermission(onCompletion: @escaping PermissionStatusHandler) {
        if #available(iOS 10.0, *) {
            let current = UNUserNotificationCenter.current()
            current.getNotificationSettings(completionHandler: { (settings) in
                
                switch settings.authorizationStatus {
                case .authorized:
                    self.shouldShowPushnotificationPermission = false
                    onCompletion(.granted, "Access already granted")
                    break
                case.notDetermined:
                    let center = UNUserNotificationCenter.current()
                    center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                        if granted {
                            onCompletion(.granted, "Access granted")
                            DispatchQueue.main.async {
                                UIApplication.shared.registerForRemoteNotifications()
                            }
                        }
                        else {
                            onCompletion(.justDenied, "Access denied")
                        }
                    }
                    break
                default:
                    onCompletion(.denied,"Access already Denied")
                    break
                }
            })
        } else {
            // Fallback on earlier versions
            if self.shouldShowPushnotificationPermission {
                onCompletion(.granted, "Access already granted")
            } else {
                let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
                let pushNotificationSettings = UIUserNotificationSettings.init(types: notificationTypes, categories: nil)
                DispatchQueue.main.async {
                    UIApplication.shared.registerUserNotificationSettings(pushNotificationSettings)
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    /**
     Request access for Photos to the user
     
     - parameter onCompletion: The completion handler for all scenarios. Returns tuple (permissionStatus, message) of types (PermissionStatus, String)
     */
    func getPhotosAccess(onCompletion: @escaping PermissionStatusHandler) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    onCompletion(.granted, "Access granted")
                }
                else {
                    onCompletion(.justDenied, "Access denied")
                }
            })
            break
        case .authorized:
            onCompletion(.granted,"Access already granted")
            break
        default:
            onCompletion(.denied,"Access already Denied")
            break
        }
    }
    
    /**
     Request access for Camera to the user
     
     - parameter onCompletion: The completion handler for all scenarios. Returns tuple (permissionStatus, message) of types (PermissionStatus, String)
     */
    func getCameraAccess(onCompletion: @escaping PermissionStatusHandler) {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case AVAuthorizationStatus.notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                if granted {
                    onCompletion(.granted, "Access granted")
                }
                else {
                    onCompletion(.justDenied, "Access denied")
                }
            })
            break
        case AVAuthorizationStatus.authorized:
            onCompletion(.granted, "Access already granted")
            break
        default:
            onCompletion(.denied,"Access already Denied")
            break
        }
    }
    
    /**
     Request access for Device Contacts to the user
     
     - parameter onCompletion: The completion handler for all scenarios. Returns tuple (permissionStatus, message) of types (PermissionStatus, String)
     */
    func getContactsAccess(onCompletion: @escaping PermissionStatusHandler) {
        let contactsAuthStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch contactsAuthStatus {
        case .notDetermined:
            let store = CNContactStore()
            store.requestAccess(for: CNEntityType.contacts, completionHandler: { (status, error) in
                guard status else {
                    onCompletion(.justDenied, "Access Just Denied")
                    return
                }
                onCompletion(.granted, "Access granted")
                return
            })
            break
        case .authorized:
            onCompletion(.granted, "Access already granted")
            break
        default:
            onCompletion(.denied, "Access already denied")
            break
        }
    }
    
    /**
     Request access for Device Location to the user
     
     - parameter onCompletion: The completion handler for all scenarios. Returns tuple (permissionStatus, message) of types (PermissionStatus, String)
     */
    func getLocationAccess(onCompletion: @escaping PermissionStatusHandler) {
        locationPermissionsHandler = onCompletion

        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            break
        case .authorizedAlways:
            onCompletion(.granted, "Access granted for always use")
            break
        default:
            onCompletion(.justDenied, "Access not granted for always use")
            break
        }
    }
}

//MARK: - CLLocationManagerDelegate Method
extension OMPermissionsManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard let locationPermissionsHandler = locationPermissionsHandler else {
            return
        }
        
        switch status {
        case .authorizedAlways:
            locationPermissionsHandler(.granted, "Access granted for always use")
            break
        default:
            locationPermissionsHandler(.justDenied, "Access not granted for always use")
        }
        
        self.locationPermissionsHandler = nil
    }
}
