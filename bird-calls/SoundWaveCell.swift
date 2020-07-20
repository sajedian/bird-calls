//
//  SoundWaveCell.swift
//  bird-calls
//
//  Created by Renee Sajedian on 5/29/20.
//  Copyright © 2020 Renee Sajedian. All rights reserved.
//

import UIKit
import FDWaveformView
import AVFoundation

protocol SoundWaveCellDelegate: class {
    func soundWaveCellPlayButtonTapped(_ soundWaveCell: SoundWaveCell)
}
class SoundWaveCell: UITableViewCell {

    @IBOutlet var colorView: UIView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var waveFormView: FDWaveformView!

    var animator: UIViewPropertyAnimator?
    var duration: TimeInterval?
    weak var delegate: SoundWaveCellDelegate?

    var shouldReset: Bool = false
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                playButton.setImage(pauseImage, for: .normal)
                animateWaveForm()

            } else {
                playButton.setImage(playImage, for: .normal)
                pauseAnimateWaveForm()
            }
        }
    }

    let playImage = UIImage(systemName: "play.circle")
    let pauseImage = UIImage(systemName: "pause.circle")

    @IBAction func playButtonTapped(_ sender: UIButton) {
        isPlaying = !isPlaying
        delegate?.soundWaveCellPlayButtonTapped(self)
    }


    func animateWaveForm() {
        if shouldReset {
            animator?.stopAnimation(true)
            guard let duration = duration else { return }
            waveFormView.highlightedSamples = 0..<0
            animator = UIViewPropertyAnimator(duration: duration, curve: .linear) { [unowned self] in
                        let totalSamples = self.waveFormView.totalSamples
                        self.waveFormView.highlightedSamples = 0..<totalSamples
            }
            shouldReset = false
        }
        animator?.startAnimation()
    }

    func pauseAnimateWaveForm() {
        animator?.pauseAnimation()
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        colorView.layer.cornerRadius = 10
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

        waveFormView.wavesColor = UIColor.white.withAlphaComponent(0.75)
        waveFormView.progressColor = .green
        waveFormView.doesAllowScroll = false
        waveFormView.doesAllowStretch = false
        waveFormView.doesAllowScrubbing = false
        waveFormView.delegate = self

       }

}

extension SoundWaveCell: FDWaveformViewDelegate {
    func waveformViewDidRender(_ waveformView: FDWaveformView) {
        if let duration = duration {
            animator = UIViewPropertyAnimator(duration: duration, curve: .linear) { [unowned self] in
                        let totalSamples = self.waveFormView.totalSamples
                        self.waveFormView.highlightedSamples = 0..<totalSamples
            }
        }
    }
}
