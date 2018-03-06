//
//  UIColorExtension.swift
//  OMNI
//
//  Created by Chandrachudh on 05/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    /**
     Use this to get colors from hex values
     
     - parameter fromHex: Hex value of the format : 0xFFFFFF
     - parameter alpha: The alpha value for the color
     
     - returns: The UIColor from the given Hex value and alpha
     */
    class func rgba(fromHex: Int, alpha: CGFloat) -> UIColor {
        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
