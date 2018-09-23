//
//  InfluencerViewController.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class InfluencerViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var proceedView: UIView!
    var influencerName: String! {
        didSet {
            fetchScreen()
        }
    }
    var selectedImages = [UIImage]()
    var imagesSentCount = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func fetchScreen() {
        APIClient.getInfluencerDetail(with: influencerName) { (result) in
            print(result)
        }
    }
    
    @IBAction func broadcastPressed(_ sender: UIButton) {
    }
}



extension InfluencerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCell") as! InfluencerStyleCell
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell")
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        default:
            return 200
        }
    }
}



extension InfluencerViewController: InfluencerStyleCellDelegate {
    
    func itemSelected(image: UIImage) {
        if selectedImages.count == 0 {
            proceedView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 100)
            view.addSubview(proceedView)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.proceedView.frame = CGRect(x: 0, y: self.view.frame.height-100, width: self.view.frame.width, height: 100)
            }, completion: { success in
            })
            if selectedImages.contains(image) {
                selectedImages.remove(at: selectedImages.lastIndex(of: image)!)
            }
            else {
                selectedImages.append(image)
            }
        }
    }
}
