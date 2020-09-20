//
//  DiscoveryViewController.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/9/11.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

class DiscoveryViewController: UITableViewController {
    
    //搜索
    let resultViewController = ResultContainerViewController();
    var searchController: UISearchController!
    var cusSearchBar:JJCustomSearchbar!
    var musicSearchController:MusicSearchViewController!
    
    // 数据源
    var homeDataSource:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置搜索栏
        setupSearchController()
        // 初始化
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.cusSearchBar.adjustPosition()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.cusSearchBar.resignFirstResponder()
    }
    
    // 设置搜索视图
    func setupSearchController () {
        let leftItem = UIBarButtonItem(image: UIImage(named: "icon-gmail")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(microphoneBtnClicked))
        let rightItem = UIBarButtonItem(image: UIImage(named: "icon-hangouts")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(playingBtnClicked))
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
        
        self.cusSearchBar = JJCustomSearchbar(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        self.cusSearchBar.delegate = self
        self.navigationItem.titleView = self.cusSearchBar
        
    }

    
    @objc func microphoneBtnClicked(){
        print("11111111")
    }
    
    @objc func playingBtnClicked(){
        print("22222222")
    }
    
    
    // Mark UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50.0
    }


    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 40.0
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // Mark UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.contentView.backgroundColor = UIColor.red
        return cell
    }
}

extension DiscoveryViewController: UISearchBarDelegate {
    // 点击跳转
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.musicSearchController = MusicSearchViewController()
        self.navigationController?.pushViewController(self.musicSearchController, animated: false)
        return true
    }
}
