//
//  NativeAdView.swift
//  Instagram
//
//  Created by Vikram Nag on 7/29/18.
//  Copyright © 2018 Vikram Nag Ashoka. All rights reserved.
//

import UIKit
import AdsNativeSDK
import CoreGraphics

//import AdsNativeSDK.h //AdsNativeSDK.h

class NativeAdView: UIView, ANAdRendering {
    @IBOutlet weak var adtitle: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    @IBOutlet weak var cta: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var sponsoredText: UILabel!
    @IBOutlet weak var mediaView:UIView!
    @IBOutlet weak var adChoicesView: UIView!
    
    func layoutAdAssets(_ adObject: PMNativeAd!) {
        adObject.loadTitle(into: self.adtitle)
        adObject.loadText(into: self.summary)
        adObject.loadCallToActionText(into: self.cta)
        adObject.loadIcon(into: self.iconImage)
        adObject.loadSponsoredTag(into: self.sponsoredText)
//      For video ads
//      [adObject loadMediaIntoView:self.mediaView];
//        
//      Optional: some third party sdks mandate it
//      [adObject loadAdChoicesIconIntoView:self.adChoicesView];
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

}
