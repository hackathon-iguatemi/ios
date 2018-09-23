//
//  SearchCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var followersCount: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    var namesString = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchSimilars()
    }
    
    func fetchSimilars() {
        if let URL = Bundle.main.url(forResource: "Selection", withExtension: "plist") {
            if let plistRes = NSArray(contentsOf: URL) as? [String] {
                namesString = plistRes
            }
        }
        collectionView.reloadData()
    }
}



extension HomeCell: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeAdCell
        cell.imageView.image = UIImage(named: "ad\(Int.random(in: 1 ..< 6))")
        if namesString.count > 0 {
            cell.aboutLabel.text = namesString[Int.random(in: 1 ..< 6)]
        }
        
        return cell
    }
}
