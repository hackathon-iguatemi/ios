//
//  ViewController.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import algorithmia

class ViewController: UIViewController {

    @IBOutlet var inputImageView: UIImageView!
    @IBOutlet var resultTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image1 = "https://images.bewakoof.com/utter/content/2968/content_skater_skirt_women_bewakoof_blog_1.jpg"
        let image2 = "https://www.shopperwear.com/media/catalog/product/cache/1/thumbnail/600x/17f82f742ffe127f42dca9de82fb58b1/p/l/plus-size-clothing-men-shirts-long-sleeve-2017-new-spring-solid-color-slim-fit-shirt-cotton-casual-shirt-men-clothes-extra-image-4.jpg"
        
        let inputImage = image1
       
        let url = URL(string: inputImage)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            inputImageView.image = image
        }
        
        let input = "{"
            + "  \"image\": \"\(inputImage)\","
            + "  \"model\": \"small\","
            + "  \"tags_only\": true"
            + "}";
        let client = Algorithmia.client(simpleKey: "simfKLbuEF4N1tN+q/QrjWml+EO1")
        let algo = client.algo(algoUri: "algorithmiahq/DeepFashion/1.3.0")
        algo.pipe(rawJson: input) { resp, error in
            let jsonData = try! JSONSerialization.data(withJSONObject: resp.getJson(), options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            self.resultTextView.text = jsonString
        }
        // Do any additional setup after loading the view, typically from a nib.
    }


}
