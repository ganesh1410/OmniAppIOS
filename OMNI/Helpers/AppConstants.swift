//
//  AppConstants.swift
//  OMNI
//
//  Created by Chandrachudh on 05/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Screen Size constants
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

//MARK: - Accesibility Constants
let YES = true
let NO = false

let CURRENT_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let CURRENT_BUILD_NUMBER = Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String

//MARK: - Device Type Constants
enum DeviceType {
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case iPhoneX
}

let currentDeviceType:DeviceType = {
    var deviceType = DeviceType.iPhone6Plus
    
    if SCREEN_HEIGHT < 600 {
        deviceType = .iPhone5
    }
    else if SCREEN_HEIGHT < 670 {
        deviceType = .iPhone6
    }
    else if SCREEN_HEIGHT > 800 {
        deviceType = .iPhoneX
    }
    
    return deviceType
}()

//MARK: Enums For Toasts
enum HudPosition {
    case top,bottom
}

enum HudBgColor {
    case red,blue,gray
}

//MARK: - String Constants
let APP_NAME = "OMNI MESSENGER"

//MARK: - Other Constants
let MIN_PASSWORD_CHARACTERS = 6
