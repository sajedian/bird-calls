//
//  SoundWaveCell.swift
//  bird-calls
//
//  Created by Renee Sajedian on 5/29/20.
//  Copyright © 2020 Renee Sajedian. All rights reserved.
//

import UIKit

protocol SoundWaveCellDelegate: class {
    func soundWaveCellPlayButtonTapped(_ soundWaveCell: SoundWaveCell)
}
class SoundWaveCell: UITableViewCell {

    @IBOutlet var colorView: UIView!
    @IBOutlet var playButton: UIButton!

    @IBAction func playButtonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.soundWaveCellPlayButtonTapped(self)
        }
    }

    weak var delegate: SoundWaveCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        colorView.layer.cornerRadius = 11
        colorView.layer.shadowColor = UIColor.black.cgColor
        colorView.layer.shadowOffset = CGSize(width: 0, height: 3)
        colorView.layer.shadowOpacity = 0.4
        colorView.layer.shadowRadius = 2
        colorView.clipsToBounds = false
        colorView.layer.masksToBounds = false
        
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false

        clipsToBounds = false
        layer.masksToBounds = false
       }


}
