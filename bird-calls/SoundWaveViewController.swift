//
//  FirstViewController.swift
//  bird-calls
//
//  Created by Renee Sajedian on 7/17/20.
//  Copyright © 2020 Renee Sajedian. All rights reserved.
//

import UIKit
import AVFoundation
import FDWaveformView

class SoundWaveViewController: UITableViewController {

    var playingCell: SoundWaveCell?
    var currentPlayingIndex: Int? {
        didSet {
            if let index = currentPlayingIndex {
                let file = files[index]
                currentPlayingFile = file
            }
        }
    }
    var currentPlayingFile: AudioFile? {
        didSet {
            if let file = currentPlayingFile {
                file.avPlayer?.delegate = self
            }
        }
    }

    var files = [
        AudioFile(name: "rose-breasted-grosbeak-1.m4a"),
        AudioFile(name: "XC46782 - Neblina Tapaculo - Scytalopus altirostris.mp3"),
        AudioFile(name: "XC55554 - Rufous-capped Spinetail - Synallaxis ruficapilla.mp3")

    ]
    var filenames = ["XC10000 - Thrush-like Antpitta - Myrmothera campanisona signata.mp3",
                     "XC46782 - Neblina Tapaculo - Scytalopus altirostris.mp3",
                     "XC55554 - Rufous-capped Spinetail - Synallaxis ruficapilla.mp3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SoundWaveCell", bundle: nil), forCellReuseIdentifier: "SoundWaveCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SoundWaveCell",
                                                       for: indexPath) as? SoundWaveCell else {
            fatalError("Failed to dequeue SoundWaveCell")
        }
        let audioFile = files[indexPath.row]
        cell.waveFormView.audioURL = audioFile.url
        cell.duration = audioFile.duration
        cell.delegate = self
        cell.shouldReset = false
        cell.isPlaying = false
        return cell
    }
}

extension SoundWaveViewController: SoundWaveCellDelegate {

    func playAudio(index: Int) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

        } catch {
            print("error activating audio session")
        }

        let audioFile = files[index]
        if index == currentPlayingIndex {
            currentPlayingFile?.play()
        } else {
            currentPlayingFile?.pause()
            currentPlayingFile = audioFile
            currentPlayingFile?.play()
        }

    }

    func pauseAudio() {
        currentPlayingFile?.pause()
        currentPlayingFile = nil
    }

    func soundWaveCellPlayButtonTapped(_ soundWaveCell: SoundWaveCell) {
        guard let row = tableView.indexPath(for: soundWaveCell)?.row else {
            print("Failed to find index for soundWaveCell")
            return
        }
        if soundWaveCell.isPlaying {
            playAudio(index: row)
            if let playingCell = playingCell {
                playingCell.isPlaying = false
            }
            playingCell = soundWaveCell
        } else {
            pauseAudio()
            playingCell = nil
        }
    }

}

extension SoundWaveViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            playingCell?.isPlaying = false
            playingCell?.shouldReset = true
            playingCell = nil
        }
    }
}
