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
        homeViewModel.fetchData(url: "http://10.200.22.108/homepage/dragon/ball")
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
        let leftItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(microphoneBtnClicked))
        let rightItem = UIBarButtonItem(image: UIImage(named: "microphone")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(playingBtnClicked))
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
//        if (section == 0 || section == 1) {
//            return 0;
//        }
//        
//        return HEADVIEW_H
        return 0
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0
    }
        
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0 || section == 1 {
//            return nil
//        }
//
//        let headerView: JJTableViewHeader = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
//        headerView.tagDelegate = self
//
//        /// 获取headview标题和最右按钮数据
//        let item = homeViewModel.sections[section]
//        switch item.type {
//            case .PLAYLIST_RCMD:
//                let model = item as? PlaylistRcmdModel
//                headerView.setupUI(title: (model?.uiElement?.subTitle!.title)!, btnName: (model?.uiElement?.button!.text)!, type: .rightArrow)
//                break
//            case .STYLE_RCMD:
//                let model = item as? StyleRcmdModel
//                headerView.setupUI(title: (model?.uiElement?.subTitle!.title)!, btnName: (model?.uiElement?.button!.text)!, type: .play)
//                break
//            case .MUSIC_MLOG:
//                let model = item as? MusicMLOGModel
//                headerView.setupUI(title: (model?.uiElement?.subTitle!.title)!, btnName: (model?.uiElement?.button!.text)!, type: .refresh)
//                break
//            case .MGC_PLAYLIST:
//                let model = item as? MgcPlaylistModel
//                headerView.setupUI(title: (model?.uiElement?.subTitle!.title)!, btnName: (model?.uiElement?.button!.text)!, type: .rightArrow)
//                break
//            case .MUSIC_CALENDAR:
//                let model = item as? MusicCalendarModel
//                headerView.setupUI(title: (model?.uiElement?.subTitle!.title)!, btnName: (model?.uiElement?.button!.text)!, type: .calender)
//                break
//            case .OFFICIAL_PLAYLIST:
//                let model = item as? OfficialPlaylistModel
//                headerView.setupUI(title: (model?.uiElement?.subTitle!.title)!, btnName: (model?.uiElement?.button!.text)!, type: .rightArrow)
//                break
//            case .ALBUM_NEW_SONG:
//                let model = item as? AlbumNewSongModel
//                var titles:Array<String> = []
//                /// 整理 新歌 / 新碟 / 数字专辑
//                for creative in model!.creatives {
//                    if !titles.contains((creative.uiElement?.mainTitle!.title)!) {
//                        titles.append((creative.uiElement?.mainTitle!.title)!)
//                    }
//                }
//                headerView.setupUIWithMutiTags(titles: titles, btnName: "更多", type: .rightArrow)
//                break
//            case .VOICELIST_RCMD:
//                let model = item as? VoiceListRcmdModel
//                headerView.setupUI(title: (model?.uiElement?.subTitle!.title)!, btnName: (model?.uiElement?.button!.text)!, type: .rightArrow)
//                break
//            case .PODCAST24:
//                let model = item as? Podcast24Model
//                headerView.setupUI(title: (model?.uiElement?.subTitle!.title)!, btnName: "", type: .none)
//                break
//            case .VIDEO_PLAYLIST:
//                let model = item as? VideoPlaylistModel
//                headerView.setupUI(title: (model?.uiElement?.subTitle!.title)!, btnName: (model?.uiElement?.button!.text)!, type: .rightArrow)
//                break
//            default:
//                break
//        }
        
//        return headerView
        return nil
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
