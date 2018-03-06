//
//  StringExtensions.swift
//  OMNI
//
//  Created by Chandrachudh on 05/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    /**
     Changes the line space between two lines in a mutable atributted string
     
     - parameter space: The space between two lines
     - parameter alignment: The alignment of the text
     
     - returns: NSMutableAttributedString with new line spaces from the parameters.
     */
    func addParagraphLineSpacing(space:CGFloat, alignment:NSTextAlignment) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        paragraphStyle.alignment = alignment
        
        addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange.init(location: 0, length: string.count))
    }
    
    /**
     Changes spaces between two characters in a mutable attributed string
     
     - parameter spacing: The space between two characters
     
     - returns: NSMutableAttributedString with new character spaces from the parameter.
     */
    func addCharacterSpacing(spacing:CGFloat) {
        addAttribute(NSAttributedStringKey.kern, value: spacing, range: NSRange.init(location: 0, length: string.count))
    }
}

extension String {
    
    /**
     Checks if the string is empty after removing the white spaces and newlines at both ends
     
     - returns: True when the string is empty.
     */
    func isEmpty() -> Bool {
        return (trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0) ? true : false
    }
    
    /**
     Checks if the string matches with the REGEX for validating email address
     
     - returns: True when the string is a valid email.
     */
    func isEmail() -> Bool {
        let regExPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regExPattern)
        if (!self.hasEmoji && predicate.evaluate(with: self)) {
            return true;
        }
        return false;
    }
    
    /**
     Checks if the string has any Emojis. It is true when an emoji is present.
     */
    public var hasEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F:   // Variation Selectors
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /**
     Checks if the string satisfies all the conditions by Omni Messenger app to be a valid password
     
     - returns: A tuple of status as Bool and the validation message as a string. (status, message)
     */
    func isAValidPassword() -> (Bool,String) {
        if isEmpty() {return (false, "Password is empty")}
        if hasEmoji {return (false, "Password contains Emoji")}
        
        if self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count < MIN_PASSWORD_CHARACTERS {
            return (false, "Password should have atleast \(MIN_PASSWORD_CHARACTERS) characters")
        }
        
        return (true,"Valid password")
    }
}
