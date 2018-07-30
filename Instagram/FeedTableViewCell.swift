//
//  FeedTableViewCell.swift
//  Instagram
//
//  Created by Vikram Nag on 6/8/18.
//  Copyright © 2018 Vikram Nag Ashoka. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var postedImage: UIImageView!
    //@IBOutlet weak var postedImage: UIImageView!
    
    @IBOutlet weak var caption: UILabel!
    
    
    @IBOutlet weak var likeCountDisplay: UITextField!
    @IBOutlet weak var userInfo: UILabel!
    
    @IBAction func likeAction(_ sender: Any) {
        if let newImg = UIImage(named: "heart-black-button-symbol-of-interface-for-social-likes.png"){
            likeButton.setImage(newImg, for: .normal)
            print(likeButton.state)
        }
    }
    @IBOutlet weak var likeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
