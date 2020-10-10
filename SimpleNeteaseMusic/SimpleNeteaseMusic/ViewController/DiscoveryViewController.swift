//
//  DiscoveryViewController.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/9/11.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SwiftyJSON

// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


class DiscoveryViewController: UITableViewController {
    
    //搜索
    let resultViewController = ResultContainerViewController();
    var searchController: UISearchController!
    var cusSearchBar:JJCustomSearchbar!
    var musicSearchController:MusicSearchViewController!
    
    // 数据源
    var bannersData = [BannerModel]()
    var homeDataSource:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置搜索栏
        setupSearchController()
        // 初始化 请求首页数据
        fetchBanner(url: "http://localhost:3000/banner?type=2")
        
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

    // 请求轮播图数据
    func fetchBanner(url: String){
        NetworkTools.requestData(MethodType.get, URLString: url, parameters: nil) { (result) in
            let json = JSON(result)
            let banners = json["banners"]
            for i in 0 ..< banners.count {
                if let picUrl = banners[i]["pic"].string {
                   let model = BannerModel(pic: picUrl)
                    self.bannersData.append(model)
                }
            }
        }
    }
    
    @objc func microphoneBtnClicked(){
        print("11111111")
    }
    
    @objc func playingBtnClicked(){
        print("22222222")
    }
    
    
    // Mark UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if(indexPath.section == 0){
            return 180.0
        }
        
        return 50.0
    }


    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if (section == 0) {
            return 0;
        }
        
        return 40.0
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // Mark UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(self.bannersData.count == 0){
            return 1;
        }
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(self.bannersData.count == 0){
            return 0;
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        if indexPath.section == 0 {
            let scrollBanner:JJScrollerBanner = JJScrollerBanner(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200))
            cell.addSubview(scrollBanner)
        } else {
            
            cell.contentView.backgroundColor = UIColor.red
            
        }
        
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
