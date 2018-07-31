//
//  NativeAdView.swift
//  Instagram
//
//  Created by Vikram Nag on 7/29/18.
//  Copyright © 2018 Vikram Nag Ashoka. All rights reserved.

import UIKit
import AdsNativeSDK
import CoreGraphics

class NativeAdView: UITableViewCell, ANAdRendering {
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var adtitle: UILabel!
    @IBOutlet weak var cta: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var sponsoredText: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func layoutAdAssets(_ adObject: PMNativeAd!) {
        adObject.loadTitle(into: adtitle)
        adObject.loadText(into: summary)
        adObject.loadCallToActionText(into: cta)
        adObject.loadIcon(into: iconImage)
        adObject.loadSponsoredTag(into: sponsoredText)
        adObject.loadImage(into: mainImage)
    }
    
    class func size(withMaximumWidth maximumWidth: CGFloat) -> CGSize {
        return CGSize.init(width: maximumWidth, height: 230)
    }
    
    class func nibForAd() -> String! {
        return "NativeAdView";
    }
}
