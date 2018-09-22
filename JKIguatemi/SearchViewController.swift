//
//  SearchViewController.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let search = UISearchController(searchResultsController: nil)
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.contentInset = UIEdgeInsets(top: 40,left: 0,bottom: 0,right: 0)
    }

}



extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
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


