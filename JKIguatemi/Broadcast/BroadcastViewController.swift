//
//  BroadcastViewController.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Lottie

class BroadcastViewController: UIViewController {

    @IBOutlet var loadingContainerView: UIView!
    var imagesURL = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        let animationView = LOTAnimationView(name: "loading")
        animationView.frame = loadingContainerView.bounds
        loadingContainerView.addSubview(animationView)
        animationView.loopAnimation = true
        animationView.contentMode = .scaleAspectFit
        animationView.play{ (finished) in
        }
        Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { (timer) in
            timer.invalidate()
            self.performSegue(withIdentifier: "toSelectionVC", sender: nil)
        }
    }
}



extension BroadcastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesURL.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageURL = imagesURL[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BroadcastCell
        cell.imageURL = imageURL
        return cell
    }
}

