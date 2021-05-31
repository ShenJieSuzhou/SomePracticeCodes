//
//  DiscoveryViewController.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/9/11.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Foundation

// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


class DiscoveryViewController: UITableViewController {
    
    @IBOutlet var homeTableView: UITableView!
    
    //搜索
    fileprivate var indicatorView: UIActivityIndicatorView!
    let resultViewController = ResultContainerViewController();
    var searchController: UISearchController!
    var cusSearchBar:JJCustomSearchbar!
    var musicSearchController:MusicSearchViewController!
    
    // 首页发现 viewModel
    fileprivate var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景
        self.view.backgroundColor = UIColor.darkModeViewColor
        // 设置搜索栏
        setupSearchController()
        // 获取首页数据
        indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.color = .red
        indicatorView.startAnimating()
        homeTableView.register(ScrollBannerCell.self, forCellReuseIdentifier: ScrollBannerCell.identifier)
        homeTableView.register(CircleMenusCell.self, forCellReuseIdentifier: CircleMenusCell.identifier)
        homeTableView.tableFooterView = indicatorView
        
        homeTableView.delegate = self
        homeViewModel.delegate = self
        homeViewModel.fetchData(url: "http://localhost:3000/homepage/dragon/ball")
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
}


extension DiscoveryViewController {
    // Mark UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return homeViewModel.sections[indexPath.section].rowHeight
    }


    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if (section == 0 || section == 1) {
            return 0;
        }
        return 40.0
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width: CGFloat = tableView.frame.size.width
        let height: CGFloat = 40
        let headerView: JJTableViewHeader = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: width, height: height))
        headerView.backgroundColor = .darkModeViewColor
        headerView.tagDelegate = self
        if section == 2 {
            headerView.setupUI(title: "人气歌单推荐", btnName: "查看更多")
        } else if section == 3 {
            headerView.setupUI(title: "欲罢不能的电音旋律", btnName: "播放全部")
        } else if section == 4 {
            headerView.setupUI(title: "专属场景歌单", btnName: "查看更多")
        } else if section == 5 {
            headerView.setupUIWithMutiTags(titles: ["新歌","新碟"], btnName: "查看更多")
        } else if section == 6 {
            headerView.setupUI(title: "排行榜", btnName: "更多")
        }
        
        return headerView
    }
}

extension DiscoveryViewController {
    // Mark UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        if homeViewModel.sections.isEmpty {
            return 0
        }
        return homeViewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return homeViewModel.sections[section].rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = homeViewModel.sections[indexPath.section]
        switch item.type {
        case .BANNER:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ScrollBannerCell.identifier, for: indexPath) as? ScrollBannerCell {
                cell.item = item
                return cell
            }
            break
        case .MENUS:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CircleMenusCell.identifier, for: indexPath) as? CircleMenusCell {
                cell.item = item
                return cell
            }
            break
        default:
            break
        }
        
//        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CellReuseIdentifier")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
//        if indexPath.section == 0 {
//            let scrollBanner:JJScrollerBanner = JJScrollerBanner(frame: CGRect(x: 10, y: 10, width: SCREEN_WIDTH - 20, height: 180))
//            scrollBanner.setBannerImages(images: self.bannersData)
//            cell.addSubview(scrollBanner)
            
//            let firstImage:UIImageView = UIImageView()
//            firstImage.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200)
//            firstImage.contentMode = .scaleAspectFill
//            firstImage.isUserInteractionEnabled = true
////            firstImage.setMyImage(URL: NSURL(string: "http://p1.music.126.net/Hg-1mnhZp-NTvo8CMD6osg==/109951165350682670.jpg"))
//            let url = URL(string: "http://p1.music.126.net/Hg-1mnhZp-NTvo8CMD6osg==/109951165350682670.jpg")
//            firstImage.kf.setImage(with: url)
//            cell.addSubview(firstImage)
           
//            cell.contentView.addSubview(adScrollerBanner)
//        } else if indexPath.section == 1 {
//            cell.contentView.addSubview(menusView)
//        } else if indexPath.section == 2 {
//            cell.contentView.addSubview(hotAlbumsView)
//        } else if indexPath.section == 3 {
//
//            cell.contentView.addSubview(privateSongListView)
//        } else if indexPath.section == 4 {
//            cell.contentView.addSubview(exclusivePlaylistView)
//        } else if indexPath.section == 5 {
//            cell.contentView.addSubview(newReleaseSongListView)
//        } else if indexPath.section == 6 {
////            cell.frame = CGRect(x: 0, y: 0, width: rankView.width, height: rankView.height)
//            cell.contentView.addSubview(rankView)
//        } else {
//            cell.contentView.backgroundColor = UIColor.clear
//        }
        
        // return the default cell if none of above succeed
           return UITableViewCell()
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

extension DiscoveryViewController: TagSwitchDelegate {
    // Tag 切换
    func tagSwitchTo(to index: Int) {
        // refresh 数据
        print("1111111");
    }
}

extension DiscoveryViewController: HomeViewModelDelegate{
    
    func onFetchComplete(){
        indicatorView.stopAnimating()
        homeTableView.reloadData()
    }
    
    func onFetchFailed(with reason: String){
        indicatorView.stopAnimating()
        homeTableView.reloadData()
    }
}
