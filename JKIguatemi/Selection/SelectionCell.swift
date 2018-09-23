//
//  SelectionCell.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 23/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class SelectionCell: UICollectionViewCell {
    
    private struct Constants {
        static let animationSpeed: Float = 0.86
        static let rotationRadius: CGFloat = 15
    }
    
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
    }
    
    override var center: CGPoint {
        didSet {
            updateVisual()
        }
    }
    
    override internal func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        updateVisual()
    }
    
    func updateVisual() {
        let rotation = atan2(transform.b, transform.a) * 100
        switch rotation {
        case -1 * Constants.rotationRadius ..< 0:
            break
        case Constants.rotationRadius ... CGFloat.greatestFiniteMagnitude:
            break
        default:
            break
        }
    }
}
