//
//  SearchViewController.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchVC")
        let search = UISearchController(searchResultsController: searchVC)
        definesPresentationContext = true
        navigationItem.searchController = search
        search.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.contentInset = UIEdgeInsets(top: 40,left: 0,bottom: 0,right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let _ = segue.destination
    }

}



extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toInfluencerVC", sender: nil)
    }
}



extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
    }
}


