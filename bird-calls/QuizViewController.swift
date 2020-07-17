//
//  FirstViewController.swift
//  bird-calls
//
//  Created by Renee Sajedian on 7/17/20.
//  Copyright © 2020 Renee Sajedian. All rights reserved.
//

import UIKit
import AVAudioPlayer

class QuizViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

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
        return cell
    }
}
