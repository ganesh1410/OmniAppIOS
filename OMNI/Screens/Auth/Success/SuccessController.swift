//
//  SuccessController.swift
//  OMNI
//
//  Created by Ganesh on 07/03/2018.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class SuccessController: UIViewController {

    @IBOutlet var rootView: UIView!
    @IBOutlet weak var lblsetMessage: UILabel!
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var wecomeViewShadow: UIView!
    @IBOutlet weak var lcGroup5Height: NSLayoutConstraint!
    @IBOutlet weak var lcContinueButtonHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // this function adds corner radius and shadow to view
        prepareViews()

        // adds background gradient
        addAppThemeGradientToTheBackground()
        
        
        if currentDeviceType == .iPhone5 {
            lcGroup5Height.constant = 100.0
        }
        view.layoutIfNeeded()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareViews(){
        welcomeView.layer.cornerRadius = 8.0
        wecomeViewShadow.layer.cornerRadius = 8.0
        wecomeViewShadow.addShadowWith(shadowPath: UIBezierPath.init(roundedRect: wecomeViewShadow.bounds, cornerRadius: 8.0).cgPath, shadowColor: UIColor.rgba(fromHex: 0x000000, alpha: 0.2).cgColor, shadowOpacity: 0.4, shadowRadius: 10.0, shadowOffset: CGSize(width: 0, height: 10))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


