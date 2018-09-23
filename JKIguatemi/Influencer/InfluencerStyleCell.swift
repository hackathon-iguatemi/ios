//
//  InfluencerSuggestionCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

protocol  InfluencerStyleCellDelegate {
    func itemSelected()
}

class InfluencerStyleCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    var delegate: InfluencerStyleCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}



extension InfluencerStyleCell: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InfluencerStyleCollectionCell
        cell.imageView.image = UIImage(named: "image\(indexPath.row+1)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemSelected()
    }
}
