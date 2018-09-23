//
//  APIClient.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 23/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class APIClient {
    
    class func upload(image: UIImage, completion: @escaping (_ result: String) -> Void) {
        let imageData = image.jpegData(compressionQuality: 0.3)
        
        let urlString = "https://hacka-jk.herokuapp.com/upload"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let mutableURLRequest = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        
        mutableURLRequest.httpMethod = "POST"
        
        let boundaryConstant = "----------------12345";
        let contentType = "multipart/form-data;boundary=" + boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        // create upload data to send
        let uploadData = NSMutableData()
        // add image
        uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
        uploadData.append("Content-Disposition: form-data; name=\"picture\"; filename=\"file.png\"\r\n".data(using: String.Encoding.utf8)!)
        uploadData.append("Content-Type: image/jpg\r\n\r\n".data(using: String.Encoding.utf8)!)
        uploadData.append(imageData!)
        uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
        mutableURLRequest.httpBody = uploadData as Data
        let task = session.dataTask(with: mutableURLRequest as URLRequest, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                let responseString = "https://hacka-jk.herokuapp.com/get_image/\(String(data: data!, encoding: String.Encoding.utf8)!)"
                completion(responseString)                
            }
        })
        
        task.resume()
    }
    
    class func getInfluencerDetail(with name: String, completion: @escaping (_ result: String) -> Void) {
        AF.request("https://hacka-jk.herokuapp.com/images/\(name)").responseJSONDecodable (decoder: decoder){ (response: DataResponse<T>) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
}
