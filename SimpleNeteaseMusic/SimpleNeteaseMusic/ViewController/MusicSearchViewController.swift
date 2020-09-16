//
//  MusicSearchViewController.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/9/14.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

class MusicSearchViewController: UITableViewController {

    var searchController:UISearchController!
    let resultContainerView = ResultContainerViewController()
    var musics = [Results]()
    var filteredMusic = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musics = [
            Results(name: "如果爱"),
            Results(name: "情书"),
            Results(name: "龙卷风"),
            Results(name: "半岛铁盒"),
            Results(name: "世界末日"),
            Results(name: "爱在西元前"),
            Results(name: "等你下课"),
            Results(name: "黑色幽默"),
            Results(name: "我不配")
        ]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
//        resultContainerView.tableView.delegate = self
//        resultContainerView.tableView.dataSource = self
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "Search"
        self.searchController.searchBar.autocapitalizationType = .none
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.searchController?.isActive = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String){
        filteredMusic = musics.filter{ music in
            return music.name.lowercased().contains(searchText.lowercased()) || searchText == ""
        }
        
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredMusic.count
        }

        return musics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let music: Results
        if searchController.isActive {
            music = filteredMusic[(indexPath as NSIndexPath).row]
        } else {
            music = musics[(indexPath as NSIndexPath).row]
        }
        cell.textLabel!.text = music.name
        return cell
    }
    
}

extension MusicSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

extension MusicSearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
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

//extension MusicSearchViewController: UITableViewDataSource {
//     func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searchController.isActive {
//            return filteredMusic.count
//        }
//
//        return musics.count
//    }
//
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let music: Results
//        if searchController.isActive {
//            music = filteredMusic[(indexPath as NSIndexPath).row]
//        } else {
//            music = musics[(indexPath as NSIndexPath).row]
//        }
//        cell.textLabel!.text = music.name
//        return cell
//    }
//}

