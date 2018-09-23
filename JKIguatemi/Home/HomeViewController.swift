//
//  SearchViewController.swift
//  JKIguatemi
//
//  Created by Jean Paul Marinho on 22/09/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchVC")
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        definesPresentationContext = true
        navigationItem.searchController = search
        search.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.contentInset = UIEdgeInsets(top: 40,left: 0,bottom: 0,right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInfluencerVC" {
            let vc = segue.destination as! InfluencerViewController
            vc.influencerName = sender as? String

        }
        else if segue.identifier ==  "toBroadcastVC" {
            let vc = segue.destination as! BroadcastViewController
            vc.imagesURL.append(URL(string: (sender as? String)!)!)
        }
    }
    
}



extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell") as! HomeButtonCell
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        default:
            return 320
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section != 0 else {
            return
        }
        performSegue(withIdentifier: "toInfluencerVC", sender: nil)
    }
}



extension HomeViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "toInfluencerVC", sender: searchBar.text!)
    }
}



extension HomeViewController: HomeButtonCellDelegate {
    
    func scanPressed() {
        let alertVC = UIAlertController(title: "Selecione como obter a imagem", message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertVC.addAction(cameraAction)
        alertVC.addAction(photoLibraryAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
}



extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        dismiss(animated: true, completion: nil)
        APIClient.upload(image: image) { (responseString) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toBroadcastVC", sender: responseString)
            }
        }
    }
    
}
