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

class DiscoveryViewController: UITableViewController {
    
    @IBOutlet var homeTableView: UITableView!
    
    //搜索
    fileprivate var indicatorView: UIActivityIndicatorView!
    let resultViewController = ResultContainerViewController();
    var searchController: UISearchController!
    var cusSearchBar: JJCustomSearchbar!
    var musicSearchController: MusicSearchViewController!
    var newAlbumCell: NewAlbumsCell!
    
    // 首页发现 viewModel
    fileprivate var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景
        self.view.backgroundColor = UIColor.darkModeViewColor
        // 设置搜索栏
        setupSearchController()
        // 获取首页数据
//        indicatorView = UIActivityIndicatorView(style: .medium)
//        indicatorView.color = .red
//        indicatorView.startAnimating()
        homeTableView.register(ScrollBannerCell.self, forCellReuseIdentifier: ScrollBannerCell.identifier)
        homeTableView.register(CircleMenusCell.self, forCellReuseIdentifier: CircleMenusCell.identifier)
        homeTableView.register(PlaylistRcmdCell.self, forCellReuseIdentifier: PlaylistRcmdCell.identifier)
        homeTableView.register(StyleRcmdCell.self, forCellReuseIdentifier: StyleRcmdCell.identifier)
        homeTableView.register(MusicMLogCell.self, forCellReuseIdentifier: MusicMLogCell.identifier)
        homeTableView.register(MGCPlayListCell.self, forCellReuseIdentifier: MGCPlayListCell.identifier)
        homeTableView.register(OfficialPlayListCell.self, forCellReuseIdentifier: OfficialPlayListCell.identifier)
        homeTableView.register(VoiceCell.self, forCellReuseIdentifier: VoiceCell.identifier)
        homeTableView.register(VideoPlayListCell.self, forCellReuseIdentifier: VideoPlayListCell.identifier)
        homeTableView.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
        homeTableView.register(NewAlbumsCell.self, forCellReuseIdentifier: NewAlbumsCell.identifier)
        homeTableView.register(PodcastCell.self, forCellReuseIdentifier: PodcastCell.identifier)
//        homeTableView.tableFooterView = indicatorView
        
        homeTableView.delegate = self
        homeViewModel.delegate = self
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
        let leftItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(menuBtnClicked))
        let rightItem = UIBarButtonItem(image: UIImage(named: "microphone")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(microphoneBtnClicked))
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
        
        self.cusSearchBar = JJCustomSearchbar(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        self.cusSearchBar.delegate = self
        self.navigationItem.titleView = self.cusSearchBar
    }

    @objc func microphoneBtnClicked(){
        
    }
    
    @objc func menuBtnClicked(){
        
    }
}


extension DiscoveryViewController {
    // Mark UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return homeViewModel.sections[indexPath.section].rowHeight
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 || indexPath.section == 1 {
            return
        } else if indexPath.section == 2 {
            /// 左下角，右下角设置圆角
            cell.roundCorners(cell.bounds.inset(by: UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0)), corners: [.bottomLeft, .bottomRight], radius: 10)
        } else {
            /// 四边角设置圆角
            cell.roundCorners(cell.bounds.inset(by: UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0)), corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        }
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
        case .PLAYLIST_RCMD:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistRcmdCell.identifier, for: indexPath) as? PlaylistRcmdCell {
                cell.item = item
                return cell
            }
            break
        case .STYLE_RCMD:
            if let cell = tableView.dequeueReusableCell(withIdentifier: StyleRcmdCell.identifier, for: indexPath) as? StyleRcmdCell {
                cell.item = item
                return cell
            }
            break
        case .MUSIC_MLOG:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MusicMLogCell.identifier, for: indexPath) as? MusicMLogCell {
                cell.item = item
                return cell
            }
            break
        case .MGC_PLAYLIST:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MGCPlayListCell.identifier, for: indexPath) as? MGCPlayListCell {
                cell.item = item
                return cell
            }
            break
        case .MUSIC_CALENDAR:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell {
                cell.item = item
                return cell
            }
            break
        case .OFFICIAL_PLAYLIST:
            if let cell = tableView.dequeueReusableCell(withIdentifier: OfficialPlayListCell.identifier, for: indexPath) as? OfficialPlayListCell {
                cell.item = item
                return cell
            }
            break
        case .ALBUM_NEW_SONG:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NewAlbumsCell.identifier, for: indexPath) as? NewAlbumsCell {
                cell.item = item
                return cell
            }
            break
        case .VOICELIST_RCMD:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VoiceCell.identifier, for: indexPath) as? VoiceCell {
                cell.item = item
                return cell
            }
            break
        case .PODCAST24:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PodcastCell.identifier, for: indexPath) as? PodcastCell {
                cell.item = item
                return cell
            }
            break
        case .VIDEO_PLAYLIST:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VideoPlayListCell.identifier, for: indexPath) as? VideoPlayListCell {
                cell.item = item
                return cell
            }
            break

        }
        
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

extension DiscoveryViewController: HomeViewModelDelegate{
    
    func onFetchComplete(){
//        indicatorView.stopAnimating()
//        homeTableView.reloadData()
    }
    
    func onFetchFailed(with reason: String){
//        indicatorView.stopAnimating()
//        homeTableView.reloadData()
    }
}
