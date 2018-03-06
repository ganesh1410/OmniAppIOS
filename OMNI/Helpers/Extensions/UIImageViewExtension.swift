//
//  UIImageViewExtension.swift
//  OMNI
//
//  Created by Chandrachudh on 05/03/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

enum ImageStyle:Int {
    case squared
    case rounded
}

extension UIImageView {
    /**
     Loads the image from the URL provided. If the URL is already cached in the device then will load it from the cache else dowoad and show the image.
     
     - parameter imageUrl: The URL from which to fetch the image
     - parameter imageStyle: ImageStyle - The type of image. We have 2 options .squared & .rounded.
     
     */
    
    func setImage(imageUrl:String, imageStyle:ImageStyle, placeHolderImage:UIImage, shouldShowLoadingIndicator:Bool) {
        
        self.image = placeHolderImage
        
        if imageUrl.count == 0 {
            return
        }
        
        if shouldShowLoadingIndicator {
            setShowActivityIndicator(shouldShowLoadingIndicator)
            setIndicatorStyle(.gray)
        }
        else {
            setShowActivityIndicator(shouldShowLoadingIndicator)
        }
        
        clipsToBounds = false
        layer.shouldRasterize = true
        
        if SDWebImageManager.shared().cachedImageExists(for: NSURL.init(string: imageUrl) as URL!) {
            if(imageStyle == .rounded) {
                self.layer.cornerRadius = self.frame.height/2
            }
            else if(imageStyle == .squared){
                self.layer.cornerRadius = 0.0
            }
            self.sd_setImage(with: NSURL.init(string: imageUrl) as URL!)
            self.clipsToBounds = true
            self.layer.shouldRasterize = false
            self.animateFade(duration: 0.5)
        }
        else {
            self.sd_setImage(with: NSURL.init(string: imageUrl) as URL!, placeholderImage:placeHolderImage, options: [.avoidAutoSetImage,.highPriority,.retryFailed,.delayPlaceholder], completed: { (image, error, cacheType, url) in
                if error == nil {
                    DispatchQueue.main.async {
                        if(imageStyle == .rounded) {
                            self.layer.cornerRadius = self.frame.height/2
                        }
                        else if(imageStyle == .squared){
                            self.layer.cornerRadius = 0.0
                        }
                        self.clipsToBounds = true
                        self.layer.shouldRasterize = false
                        self.image = image
                        self.animateFade(duration: 0.5)
                    }
                }
                else {
                    self.layer.shouldRasterize = false
                }
            })
        }
    }
}
