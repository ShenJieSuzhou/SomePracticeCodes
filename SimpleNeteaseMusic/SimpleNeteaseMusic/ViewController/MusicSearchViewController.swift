//
//  MusicSearchViewController.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/9/14.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

class MusicSearchViewController: UIViewController {

    var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSearchController()
    }
    

    func setupSearchController () {
        self.searchController = UISearchController(searchResultsController: ResultContainerViewController())
        self.searchController.searchBar.becomeFirstResponder()
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        definesPresentationContext = true
        self.navigationItem.hidesBackButton = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.searchController?.isActive = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension MusicSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension MusicSearchViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.searchBar.resignFirstResponder()
    }
}
