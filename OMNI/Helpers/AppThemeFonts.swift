//
//  AppThemeFonts.swift
//  OMNI
//
//  Created by Chandrachudh on 05/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

class AppThemeFonts: NSObject {
    
    class func appThemeRegularFontWith(size:CGFloat) -> UIFont {
        return UIFont.init(name: "NunitoSans-Regular", size: size)!
    }
    
    class func appThemeBoldFontWith(size:CGFloat) -> UIFont {
        return UIFont.init(name: "NunitoSans-Bold", size: size)!
    }
    
    class func appThemeSemiBoldFontWith(size:CGFloat) -> UIFont {
        return UIFont.init(name: "NunitoSans-SemiBold", size: size)!
    }
    
    class func appThemeLightFontWith(size:CGFloat) -> UIFont {
        return UIFont.init(name: "NunitoSans-Light", size: size)!
    }
}
