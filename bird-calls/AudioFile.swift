//
//  AudioFile.swift
//  bird-calls
//
//  Created by Renee Sajedian on 7/20/20.
//  Copyright © 2020 Renee Sajedian. All rights reserved.
//

import Foundation
import AVFoundation

struct AudioFile {
    var name: String
    var duration: TimeInterval?
    var avPlayer: AVAudioPlayer?
    var url: URL

    func pause() {
        avPlayer?.pause()
    }

    func play() {
        avPlayer?.play()
    }

    init(name: String) {
        self.name = name
        let path = Bundle.main.path(forResource: name, ofType: nil)!
        self.url = URL(fileURLWithPath: path)
        do {
            try self.avPlayer = AVAudioPlayer(contentsOf: url)
            self.duration = avPlayer?.duration

        } catch {
            print("failed to load file \(name)")
            avPlayer = nil
        }
    }
}
