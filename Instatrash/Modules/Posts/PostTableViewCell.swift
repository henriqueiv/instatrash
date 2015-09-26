//
//  PostTableViewCell.swift
//  Instatrash
//
//  Created by William Hass on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet private var postImageDetailLabel : UILabel!
    @IBOutlet private var postDescriptionLabel : UILabel!
    @IBOutlet private var postImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetView()
    }
    
    func resetView() {
        setImageDetailText(nil)
        setPostDescriptionText(nil)
        setPostImage(nil)
    }
    
    func setImageDetailText(text: String?) {
        postImageDetailLabel.text = text
    }
    
    func setPostImage(image: UIImage?) {
        postImageView.image = image
    }
    
    func setPostDescriptionText(description: String?) {
        postDescriptionLabel.text = description
    }
    
}
