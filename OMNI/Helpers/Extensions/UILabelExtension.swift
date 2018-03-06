//
//  UILabelExtension.swift
//  OMNI
//
//  Created by Chandrachudh on 06/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func addParagraphLineSpacing(space:CGFloat, alignment:NSTextAlignment) {
        
        var attrStr:NSMutableAttributedString?
        
        if self.attributedText != nil {
            attrStr = self.attributedText as! NSMutableAttributedString?
        }
        else {
            attrStr = NSMutableAttributedString(string: self.text!)
        }
        attrStr?.addParagraphLineSpacing(space: space, alignment: alignment)
        self.attributedText = attrStr
    }
    
    func addCharacterSpacing(spacing:CGFloat) {
        var attrStr:NSMutableAttributedString?
        
        if self.attributedText != nil {
            attrStr = self.attributedText as! NSMutableAttributedString?
        }
        else {
            attrStr = NSMutableAttributedString(string: self.text!)
        }
        attrStr?.addCharacterSpacing(spacing: spacing)
        
        self.attributedText = attrStr
    }
}
