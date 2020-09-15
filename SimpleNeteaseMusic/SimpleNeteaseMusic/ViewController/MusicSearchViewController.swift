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
    let resultContainerView = ResultContainerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 设置打开后即呼出键盘
        searchController.isActive = true
        DispatchQueue.main.async{
            self.searchController.searchBar.becomeFirstResponder()
        }
    }

    func setupSearchController () {
        self.searchController = UISearchController(searchResultsController: resultContainerView)
        self.searchController.delegate = self
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

extension MusicSearchViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController){

    }
}
