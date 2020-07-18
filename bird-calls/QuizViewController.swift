//
//  FirstViewController.swift
//  bird-calls
//
//  Created by Renee Sajedian on 7/17/20.
//  Copyright © 2020 Renee Sajedian. All rights reserved.
//

import UIKit
import AVFoundation

class QuizViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var avPlayer: AVAudioPlayer?

    var previousPlayingCell: SoundWaveCell?

    var filenames = ["XC10000 - Thrush-like Antpitta - Myrmothera campanisona signata.mp3",
                     "XC46782 - Neblina Tapaculo - Scytalopus altirostris.mp3",
                     "XC55554 - Rufous-capped Spinetail - Synallaxis ruficapilla.mp3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SoundWaveCell", bundle: nil), forCellReuseIdentifier: "SoundWaveCell")
    }
}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SoundWaveCell",
                                                       for: indexPath) as? SoundWaveCell else {
            fatalError("Failed to dequeue SoundWaveCell")
        }
        cell.delegate = self
        return cell
    }
}

extension QuizViewController: SoundWaveCellDelegate {

    func playAudio(index: Int) {
        let filename = filenames[index]
        let path = Bundle.main.path(forResource: filename, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            avPlayer = try AVAudioPlayer(contentsOf: url)
            avPlayer?.delegate = self
            avPlayer?.play()
        } catch {
            print("error loading file")
        }

    }

    func pauseAudio() {
        avPlayer?.pause()
    }

    func soundWaveCellPlayButtonTapped(_ soundWaveCell: SoundWaveCell) {
        guard let row = tableView.indexPath(for: soundWaveCell)?.row else {
            print("Failed to find index for soundWaveCell")
            return
        }
        if soundWaveCell.isPlaying {
            playAudio(index: row)
            if previousPlayingCell != soundWaveCell {
                previousPlayingCell?.isPlaying = false
            }
            previousPlayingCell = soundWaveCell
        } else {
            pauseAudio()
        }
    }

}

extension QuizViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            previousPlayingCell?.isPlaying = false
        }
    }
}
