//
//  VerifyController.swift
//  Omni verify
//
//  Created by Ganesh on 06/03/2018.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class VerifyController: UIViewController {

    @IBOutlet var rootView: UIView!
    @IBOutlet weak var verifyTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var verifyLabel: UILabel!
    @IBOutlet weak var verifyCodeLabel: UILabel!
    @IBOutlet weak var lblBottom: UILabel!
    
    let leftImageView = UIImageView()
    let leftView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        // styles for verify field
        verifyField()
        
        addImageInTextField()
        
        let attributedString = NSMutableAttributedString(string: "Haven’t received the code? You can request to Resend code in 22 seconds")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: (attributedString.string as NSString).range(of: "Resend"))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: (attributedString.string as NSString).range(of: "Resend"))
        
        lblBottom.attributedText = attributedString
       //add corner radius to button
        verifyButton.layer.cornerRadius = 8.0


        
        addAppThemeGradientToTheBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
 
    func verifyField(){
        //  add placeholder to textfield
        if verifyTextField.placeholder != nil {
            verifyTextField.attributedPlaceholder = NSAttributedString(string:"Verification Code",
                                                                       attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
            
        }
        
        verifyTextField.layer.borderColor = UIColor( red: 255/255, green:255/255, blue:255/255, alpha: 0.8 ).cgColor
        verifyTextField.layer.borderWidth = 1.0
        verifyTextField.layer.cornerRadius = 8.0
        verifyTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    func addImageInTextField(){
        leftImageView.image = #imageLiteral(resourceName: "shield").withRenderingMode(.alwaysTemplate)
        
        leftView.addSubview(leftImageView)
        
        leftView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        leftImageView.frame = CGRect(x: 20, y: 13, width: 15, height: 15)
        leftImageView.tintColor = UIColor.white
        verifyTextField.leftViewMode = .always
        verifyTextField.leftView = leftView

        
    }
}

