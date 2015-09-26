//
//  TimelineTableSectionHeader.swift
//  Instatrash
//
//  Created by William Hass on 9/26/15.
//  Copyright © 2015 Instatrash Inc. All rights reserved.
//

import UIKit

class TimelineTableSectionHeader: UITableViewHeaderFooterView {
    
    @IBOutlet private var customBackgroundView: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var rightDetailTextLabel: UILabel!
    
    // MARK: Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        resetView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetView()
    }
    
    func resetView() {
        setImage(nil)
        setTitle(nil)
        setRightDetailText(nil)
    }

    // MARK: View Set Ups

    private func setupView() {
        backgroundView = customBackgroundView
        backgroundView?.backgroundColor = UIColor.lightGrayColor()
    }

    func setImage(image: UIImage?) {
        imageView.image = image
    }
    
    func setTitle(title: String?) {
        titleLabel.text = title
    }
    
    func setRightDetailText(detail: String?) {
        rightDetailTextLabel.text = detail
    }
    
}
