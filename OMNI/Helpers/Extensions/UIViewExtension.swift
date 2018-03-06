//
//  UIViewExtension.swift
//  OMNI
//
//  Created by Chandrachudh on 05/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    //MARK: - Animations
    
    /**
     Adds a small fade animation to the view
     
     - parameter duration: The duration of the fade animation
     
     - returns: void
     */
    func animateFade(duration:Double) {
        DispatchQueue.main.async {
            self.layer.removeAllAnimations()
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.type = kCATransitionFade
            animation.duration = duration
            self.layer.add(animation, forKey: "kCATransitionFade")
        }
    }
    
    //MARK: - Manipulating Methods
    
    /**
     Adds a shadow to the view's primary layer with respect to the shadow path provided
     
     - parameter shadowPath: The CGPath needed to draw the shadow. Use UIBezierPath to create one.
     - parameter shadowColor: The CGColor for the shadow.
     - parameter shadowOpacity: The Opacity of the shadow
     - parameter shadowRadius: The shadow blur radius.
     - parameter shadowOffset: The shadow offset.
     
     */
    func addShadowWith(shadowPath:CGPath, shadowColor:CGColor, shadowOpacity:Float, shadowRadius:CGFloat, shadowOffset:CGSize) {
        layer.masksToBounds = true
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        clipsToBounds = false
        layer.shadowPath = shadowPath
    }
    
    /**
     Use this method to bring all the view's subviews to front in their order. Can be used while adding a layer programatically to a view created with IB
     */
    func bringAllSubViewsToFront() {
        for subview in subviews {
            bringSubview(toFront: subview)
        }
    }
    
    /**
     Enables the user interaction of the view object and changes restores its alpha to 1.0, this is usually used in tandem with the disableUserInteraction method.
     */
    func enableUserInteraction() {
        alpha = 1.0
        isUserInteractionEnabled = true
    }
    
    /**
     Disables the user interaction of the view object and changes its alpha to 0.3, this is usually used in tandem with the enableUserInteraction method.
     */
    func disableUserInteraction() {
        alpha = 0.3
        isUserInteractionEnabled = false
    }
    
    /**
     Changes the corner radius of a view to the half of its current height
     */
    func makeRounded() {
        clipsToBounds = true
        layer.cornerRadius = frame.height/2
    }
}
