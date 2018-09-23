//
//  BroadcastCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import algorithmia
import ANLoader

class BroadcastCell: UITableViewCell {

    @IBOutlet var styleImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    var lookImage: UIImage?
    var imageURL: URL? {
        didSet {
            fetchML()
        }
    }
    var wears = [Wear]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        styleImageView.layer.cornerRadius = 12
    }
    
    func fetchML() {
        ANLoader.showLoading()
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data {
            styleImageView.image = UIImage(data: imageData)
        }
        let input = "{"
            + "  \"image\": \"\(imageURL!)\","
            + "  \"model\": \"small\","
            + "  \"tags_only\": true"
            + "}";
        let client = Algorithmia.client(simpleKey: "simfKLbuEF4N1tN+q/QrjWml+EO1")
        let algo = client.algo(algoUri: "algorithmiahq/DeepFashion/1.3.0")
        algo.pipe(rawJson: input) { resp, error in
            let decoder = JSONDecoder()
            let jsonData = try! JSONSerialization.data(withJSONObject: resp.getJson(), options: JSONSerialization.WritingOptions.prettyPrinted)
            let algorithmiaResponse = try! decoder.decode(AlgorithmiaResponse.self, from: jsonData)
            self.wears = algorithmiaResponse.articles
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                ANLoader.hide()
            }
        }
    }
}



extension BroadcastCell: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wears.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let wear = wears[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BroadcastCollectionCell
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data {
            let imageRAW = UIImage(data: imageData)
            cell.imageView.image = imageRAW?.cropped(boundingBox: CGRect(x: wear.boundingBox.x0, y: wear.boundingBox.y0, width: wear.boundingBox.x1/2, height: wear.boundingBox.y1/2))
        }
        cell.aboutLabel.text = "\(wear.name.capitalizingFirstLetter())"
        cell.confidenceLabel.text = "\(String(format: "%.2f", wear.confidence*100))%"
        return cell
    }
}
