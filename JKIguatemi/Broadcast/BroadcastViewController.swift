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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = LOTAnimationView(name: "loading")
        animationView.frame = loadingContainerView.bounds
        loadingContainerView.addSubview(animationView)
        animationView.loopAnimation = true
        animationView.contentMode = .scaleAspectFit
        animationView.play{ (finished) in
        }
    }
}



extension BroadcastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
}

