//
//  BirdCollectionViewCell.swift
//  bird-calls
//
//  Created by Renee Sajedian on 7/26/20.
//  Copyright © 2020 Renee Sajedian. All rights reserved.
//

import UIKit

class BirdCollectionViewCell: UICollectionViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var birdImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .white
        birdImageView.layer.cornerRadius = 8
        birdImageView.clipsToBounds = true
        birdImageView.layer.masksToBounds = true

        birdImageView.layer.shadowColor = UIColor.black.cgColor
        birdImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        birdImageView.layer.shadowOpacity = 0.4
        birdImageView.layer.shadowRadius = 2

        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byWordWrapping
    }
}
