//
//  BirdOptionsCollectionViewController.swift
//  bird-calls
//
//  Created by Renee Sajedian on 7/26/20.
//  Copyright © 2020 Renee Sajedian. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BirdCollectionViewCell"

class BirdOptionsCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? BirdCollectionViewCell else {
            fatalError("Failed to dequeue BirdCollectionViewCell")
        }
        let image = UIImage(named: "cardinal.jpg")?.scaled(toHeight: 100)
        cell.birdImageView.image = image

        cell.nameLabel.text = "Rose-breasted Grosbeak"
        return cell
    }
}

extension BirdOptionsCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ : UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2 - 15
        let height = collectionView.frame.size.height / 2 - 15
        return CGSize(width: width, height: height)

    }

    func collectionView(_ : UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidthPadding = CGFloat(10)
        let cellHeightPadding = CGFloat(10)
        return UIEdgeInsets(top: cellHeightPadding, left: cellWidthPadding,
                            bottom: cellHeightPadding, right: cellWidthPadding)
    }
}
