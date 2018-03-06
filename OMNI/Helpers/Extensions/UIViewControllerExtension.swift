//
//  UIViewControllerExtension.swift
//  OMNI
//
//  Created by Chandrachudh on 05/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

extension UIViewController {
    
    /**
     shows an alert dialogue with the given message and cancel button title. The alert title is always app name
     
     - parameter message: The subtitle that is to be shown in the alert dialouge
     - parameter cancelTitle: The title for the cancel button
     */
    func showAlert(message:String, cancelTitle:String) {
        let alertController = UIAlertController.init(title: APP_NAME, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     shows an UIAlertController with the given title, message and action buttons.
     
     - parameter title: The Title for the UIAlertController
     - parameter message: The subtitle that is to be shown in the UIAlertController
     - parameter actions: The UIAlertAction objects that needs to be show with the UIAlertController
     */
    func showAlertWith(title:String, message:String, actions:[UIAlertAction], alertType:UIAlertControllerStyle) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: alertType)
        
        for action in actions {
            alertController.addAction(action)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     shows an UIAlertController which on tapping enable access, takes the user to the device settings page.
     
     - parameter message: The subtitle that is to be shown in the UIAlertController
     */
    func showAlertToSettings(message:String) {
        let alertcontroller = UIAlertController.init(title: APP_NAME, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (action) in
        }
        alertcontroller.addAction(cancelAction)
        
        let settingsActions = UIAlertAction.init(title: "Enable access", style: .default) { (action) in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: { (done) in
            })
        }
        alertcontroller.addAction(settingsActions)
        
        present(alertcontroller, animated: true, completion: nil)
    }
    
    /**
     add a tapgesture to the View of this particular UIViewcontroller. This tap gestures calls the dismissKeyBoard() method to end all kind of keyboard editing in the UIViewcontroller
     */
    func addDismissGesture() {
        let keyBoardDismissGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(keyBoardDismissGesture)
        view.bringAllSubViewsToFront()
    }
    
    /**
     ends all kind of keyboard editing in the UIViewcontroller
     */
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    /**
     shows the toast message.
     
     - parameter position: HudPosition, this determines the postion of the origin of the toast. We have 2 options - .top & .bottom
     - parameter message: The message that needs to be shown in the Toast
     - parameter bgColor: HudBgColor, this determines the background color of the toast. We have 3 options - .red, .gray & .blue
     - parameter isPermanent: If this is marked as true, the toast will never disappear.
     */
    func showErrorHud(position: HudPosition, message:String, bgColor: HudBgColor, isPermanent:Bool) {
        DispatchQueue.main.async {
            
            let messageView:MessageView? = MessageView.viewFromNib(layout: .messageView)
            
            messageView?.configureContent(title: message, body: "", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
            
            switch bgColor {
            case .red:
                messageView?.configureTheme(backgroundColor:APP_THEME_ERROR_HUD_BG_COLOR, foregroundColor: UIColor.white, iconImage: nil, iconText: "")
                break
            case.gray:
                messageView?.configureTheme(backgroundColor:APP_THEME_NUETRAL_HUD_BG_COLOR, foregroundColor: UIColor.white, iconImage: nil, iconText: "")
                break
            default:
                messageView?.configureTheme(backgroundColor: APP_THEME_SUCCESS_HUD_BG_COLOR, foregroundColor: UIColor.white, iconImage: nil, iconText: "")
                break
            }
            
            messageView?.bodyLabel?.isHidden = true
            messageView?.titleLabel?.textAlignment = .center
            messageView?.titleLabel?.font = AppThemeFonts.appThemeRegularFontWith(size: 14)
            messageView?.titleLabel?.adjustsFontSizeToFitWidth = true
            messageView?.titleLabel?.adjustsFontForContentSizeCategory = true
            messageView?.titleLabel?.numberOfLines = 0
            messageView?.button?.isHidden = true
            messageView?.iconImageView?.isHidden = true
            messageView?.iconLabel?.isHidden = true
            
            var config = SwiftMessages.defaultConfig
            config.duration = .seconds(seconds: 2)
            if isPermanent == true {
                config.duration = .forever
            }
            config.dimMode = .none
            config.interactiveHide = true
            config.preferredStatusBarStyle = .lightContent
            
            if position == .bottom {
                config.presentationStyle = .bottom
            }
            else {
                config.presentationStyle = .top
            }
            
            SwiftMessages.show(config: config, view: (messageView)!)
        }
    }
    
    func addAppThemeGradientToTheBackground() {
        
        let color1 = UIColor.rgba(fromHex: 0x74DFE1, alpha: 1.0)
        let color2 = UIColor.rgba(fromHex: 0x39B1B6, alpha: 1.0)
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [NSNumber.init(value: 0.40), NSNumber.init(value: 1.0)];
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.addSublayer(gradient)
        
        view.bringAllSubViewsToFront()
    }
}
