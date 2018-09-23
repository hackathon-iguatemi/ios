//
//  Wear.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation
import UIKit

struct AlgorithmiaResponse: Codable {
    let articles: [Wear]
}

struct Wear: Codable {
    let name: String
    let confidence: Float
    let boundingBox: BoundingBox
    
    enum CodingKeys: String, CodingKey {
        case name = "article_name"
        case confidence = "confidence"
        case boundingBox = "bounding_box"
    }
}

struct BoundingBox: Codable {
    let y0: Int
    let x1: Int
    let x0: Int
    let y1: Int
}
