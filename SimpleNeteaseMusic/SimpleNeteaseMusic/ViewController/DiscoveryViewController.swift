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

// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


class DiscoveryViewController: UITableViewController {
    
    let netAdArray = ["http://pic2.16pic.com/00/10/46/16pic_1046407_b.jpg",
                      "http://pic.58pic.com/58pic/14/34/62/39S58PIC9jV_1024.jpg",
                      "http://pic.qiantucdn.com/58pic/17/70/72/02U58PICKVg_1024.jpg",
                      "http://pic.58pic.com/58pic/16/73/95/63E58PICQh7_1024.jpg"]
    
    let menus = ["每日推荐", "私人FM", "歌单", "排行榜", "宝藏声音", "每日推荐", "私人FM", "歌单", "排行榜", "宝藏声音"]
    
    @IBOutlet var homeTableView: UITableView!
    
    //搜索
    let resultViewController = ResultContainerViewController();
    var searchController: UISearchController!
    var cusSearchBar:JJCustomSearchbar!
    var musicSearchController:MusicSearchViewController!
    
    // 顶楼数据源
    var bannersData = [BannerModel]()
    var homeDataSource:NSArray!
    
    // 二楼数据源
    var menusData = [DragonBallModel]()
    
    // 三楼数据源
    var hotAlbumData = [HotListResult]()
    
    // 5楼数据源
    var exclusiveListData = [HotListResult]()
    
    // 6楼数据源
    var newReleaseList = [HotListResult]()
    
    // 顶楼轮播控件
    lazy var newsBanner: JJNewsBanner = {
        let banner = JJNewsBanner.startPlay(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200), imageUrlStrArray: self.bannersData, placeholderImage: UIImage(named: "ad_placeholder"))
        banner.currentPageDotColor = UIColor.white
        banner.pageDotColor = UIColor.gray
        banner.autoScrollTimeInterval = 5.0
        banner.pageControlDotSize = CGSize(width: 10, height: 10)
        
        return banner
    }()
    
    // 二楼菜单按钮
    lazy var menusView: HomeMenu = {
        let menusV = HomeMenu(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 160))
        menusV.update(data: menusData)
        return menusV
    }()
    
    // 三楼推荐歌单视图
    lazy var hotAlbumsView: CardCollectionView = {
        let view = CardCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        return view
    }()
    
    // 四楼私人定制视图
    lazy var privateSongListView: RowStyleCollectionView = {
        let view = RowStyleCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 240))
        return view
    }()
    
    // 五楼专属歌单
    lazy var exclusivePlaylistView: CardCollectionView = {
        let view = CardCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        return view
    }()
    
    // 六楼 新歌新碟
    lazy var newReleaseSongListView: RowStyleCollectionView = {
        let view = RowStyleCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 240))
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景
        self.view.backgroundColor = UIColor.darkModeViewColor
        // 设置搜索栏
        setupSearchController()
        // 初始化 请求首页顶楼数据
        fetchBanner(url: "http://localhost:3000/banner?type=2")
        // 请求首页二楼图标数据
        fetchDragonBall()
        // 人气歌单推荐
        fetchHotLists(url: "http://localhost:3000/personalized?limit=5")
        // 专属歌单
        fetchExclusivePlaylist(url: "http://localhost:3000/personalized?limit=5")
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
            
            // 刷新 tableView
            self.homeTableView.reloadData()
        }
    }
    
    // 请求圆形图标
    func fetchDragonBall(){
        for item in self.menus {
            var menu:DragonBallModel!
            menu = DragonBallModel(menuIcon: "music", title: item)
            self.menusData.append(menu)
        }
    }
    
    // 请求人气歌单
    func fetchHotLists(url: String) -> Void {
        NetworkTools.requestData(MethodType.get, URLString: url, parameters: nil) { (result) in
            let jsonData = try? JSONSerialization.data(withJSONObject: result, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)
                                                                            
            if let data = jsonString?.data(using: .utf8) {
                let decoder = JSONDecoder()
                if let hotAlbum = try? decoder.decode(HotAlbum.self, from: data) {
                    if hotAlbum.code == 200 {
                        self.hotAlbumData = hotAlbum.result
                        self.hotAlbumsView.updateUI(hotList: self.hotAlbumData)
                    }
                }
            }
        }
    }
    
    // 专属歌单场景
    func fetchExclusivePlaylist(url: String) -> Void {
        NetworkTools.requestData(MethodType.get, URLString: url, parameters: nil) { (result) in
            let jsonData = try? JSONSerialization.data(withJSONObject: result, options: [])
            let jsonString = String(data: jsonData!, encoding: .utf8)
            
            if let data = jsonString?.data(using: .utf8) {
                let decoder = JSONDecoder()
                if let hotAlbum = try? decoder.decode(HotAlbum.self, from: data) {
                    if hotAlbum.code == 200 {
                        self.exclusiveListData = hotAlbum.result
                        self.exclusivePlaylistView.updateUI(hotList: self.exclusiveListData)
                    }
                }
            }
        }
    }
    
    // 新歌、新碟
//    func fetchNewReleaseSongs(url: String) -> Void {
//        NetworkTools.requestData(MethodType.get, URLString: url, parameters: nil) { (result) in
//            let jsonData = try? JSONSerialization.data(withJSONObject: result, options: [])
//            let jsonString = String(data: jsonData!, encoding: .utf8)
//
//            if let data = jsonString?.data(using: .utf8) {
//                let decoder = JSONDecoder()
//                if let hotAlbum = try? decoder.decode(HotAlbum.self, from: data) {
//                    if hotAlbum.code == 200 {
//                        self.newReleaseList = hotAlbum.result
//                        self.newReleaseSongListView.updateUI(hotList: self.hotAlbumData)
//                        self.newReleaseSongListView.updateUI(hotList: self.newReleaseList)
//                    }
//                }
//            }
//        }
//    }
    
    @objc func microphoneBtnClicked(){
        print("11111111")
    }
    
    @objc func playingBtnClicked(){
        print("22222222")
    }
    
    
    // Mark UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 0 {
            return 200.0
        } else if indexPath.section == 1 {
            return 150.0
        } else if indexPath.section == 2 {
            return 180.0
        } else if indexPath.section == 3 {
            return 240.0
        } else if indexPath.section == 4 {
            return 180.0
        } else if indexPath.section == 5 {
            return 240.0
        }
 
        return 50.0
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
        }
        
        return headerView
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
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CellReuseIdentifier")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        if indexPath.section == 0 {
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
           
            cell.addSubview(newsBanner)
        } else if indexPath.section == 1 {
            cell.addSubview(menusView)
        } else if indexPath.section == 2 {
            cell.addSubview(hotAlbumsView)
        } else if indexPath.section == 3 {
            cell.addSubview(privateSongListView)
        } else if indexPath.section == 4 {
            cell.addSubview(exclusivePlaylistView)
        } else if indexPath.section == 5 {
            cell.addSubview(newReleaseSongListView)
        } else {
            cell.contentView.backgroundColor = UIColor.clear
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

extension DiscoveryViewController: TagSwitchDelegate {
    // Tag 切换
    func tagSwitchTo(to index: Int) {
        // refresh 数据
        print("1111111");
    }
}
