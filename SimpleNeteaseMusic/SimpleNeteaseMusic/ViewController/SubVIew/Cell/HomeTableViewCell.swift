//
//  HomeTableViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

/// UITableViewCell 的基类
class BaseViewCell: UITableViewCell {
    
    var headerView: JJTableViewHeader?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.homeCellColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 分页滚动 Cell
class ScrollBannerCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var scrollBanner: JJNewsBanner!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? BannerModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        scrollBanner = JJNewsBanner(frame: CGRect.zero)
        self.contentView.addSubview(scrollBanner!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUI(model: BannerModel) {
        self.scrollBanner.frame = model.frame
        self.scrollBanner.updateUI(model: model, placeholderImage: UIImage(named: "ad_placeholder"))
    }
}


/// 首页-发现 圆形按钮
class CircleMenusCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var homeMenu: HomeMenu!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? MenusModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        homeMenu = HomeMenu(frame: CGRect.zero)
        self.contentView.addSubview(homeMenu!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUI(model: MenusModel) {
        self.homeMenu.frame = model.frame
        self.homeMenu.updateUI(data: model.data)
    }
}

/// 首页-发现 推荐歌单
class PlaylistRcmdCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var rcmdPlayListView: CardCollectionView!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? PlaylistRcmdModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        headerView = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
        rcmdPlayListView = CardCollectionView(frame: CGRect.zero)
        self.contentView.addSubview(headerView!)
        self.contentView.addSubview(rcmdPlayListView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.rcmdPlayListView.frame = CGRect(x: 0, y: (headerView?.frame.maxY)!, width: self.bounds.width, height: self.bounds.height - (headerView?.frame.maxY)! - 10)
    }
    
    func setupUI(model: PlaylistRcmdModel) {
        headerView!.setupUI(title: (model.uiElement?.subTitle!.title)!, btnName: (model.uiElement?.button!.text)!, type: .rightArrow)
        self.rcmdPlayListView.updateUI(songList: model.creatives)
    }
}

/// 首页-发现 个性推荐歌单
class StyleRcmdCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var rcmdStyleView: PrivateCustomView!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? StyleRcmdModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        headerView = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
        rcmdStyleView = PrivateCustomView(frame: CGRect.zero)
        self.contentView.addSubview(headerView!)
        self.contentView.addSubview(rcmdStyleView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.rcmdStyleView.frame = CGRect(x: 0, y: (headerView?.frame.maxY)!, width: self.bounds.width, height: self.bounds.height - (headerView?.frame.maxY)!)
    }
    
    func setupUI(model: StyleRcmdModel) {
        headerView!.setupUI(title: (model.uiElement?.subTitle!.title)!, btnName: (model.uiElement?.button!.text)!, type: .play)
        self.rcmdStyleView.updateUI(privateData: model.creatives)
    }
}


/// 首页-发现 精选视频
class MusicMLogCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var musicMLogView: MusicMLogView!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? MusicMLOGModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        headerView = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
        musicMLogView = MusicMLogView(frame: CGRect.zero)
        self.contentView.addSubview(headerView!)
        self.contentView.addSubview(musicMLogView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.musicMLogView.frame = CGRect(x: 0, y: (headerView?.frame.maxY)!, width: self.bounds.width, height: self.bounds.height - (headerView?.frame.maxY)!)
    }
    
    func setupUI(model: MusicMLOGModel) {
        headerView!.setupUI(title: (model.uiElement?.subTitle!.title)!, btnName: (model.uiElement?.button!.text)!, type: .refresh)
        self.musicMLogView.updateUI(songList: model.mLog)
    }
}


/// 首页-发现 雷达歌单
class MGCPlayListCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var mgcListView: CardCollectionView!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? MgcPlaylistModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        headerView = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
        mgcListView = CardCollectionView(frame: CGRect.zero)
        self.contentView.addSubview(headerView!)
        self.contentView.addSubview(mgcListView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mgcListView.frame = CGRect(x: 0, y: (headerView?.frame.maxY)!, width: self.bounds.width, height: self.bounds.height - (headerView?.frame.maxY)!)
    }
    
    func setupUI(model: MgcPlaylistModel) {
        headerView!.setupUI(title: (model.uiElement?.subTitle!.title)!, btnName: (model.uiElement?.button!.text)!, type: .rightArrow)
        self.mgcListView.updateUI(songList: model.creatives)
    }
}

/// 首页-发现  音乐日历
class CalendarCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var calendarView: MusicCalendarView!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? MusicCalendarModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        headerView = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
        calendarView = MusicCalendarView(frame: CGRect.zero)
        self.contentView.addSubview(headerView!)
        self.contentView.addSubview(calendarView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.calendarView.frame = CGRect(x: 0, y: (headerView?.frame.maxY)!, width: self.bounds.width, height: self.bounds.height - (headerView?.frame.maxY)!)
    }
    
    func setupUI(model: MusicCalendarModel) {
        headerView!.setupUI(title: (model.uiElement?.subTitle!.title)!, btnName: (model.uiElement?.button!.text)!, type: .calender)
        self.calendarView.updateUI(data: model.creatives)
    }
}


/// 首页-发现  专属歌单
class OfficialPlayListCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var officialListView: CardCollectionView!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? OfficialPlaylistModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        headerView = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
        officialListView = CardCollectionView(frame: CGRect.zero)
        self.contentView.addSubview(headerView!)
        self.contentView.addSubview(officialListView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.officialListView.frame = CGRect(x: 0, y: (headerView?.frame.maxY)!, width: self.bounds.width, height: self.bounds.height - (headerView?.frame.maxY)!)
    }
    
    func setupUI(model: OfficialPlaylistModel) {
        headerView!.setupUI(title: (model.uiElement?.subTitle!.title)!, btnName: (model.uiElement?.button!.text)!, type: .rightArrow)
        self.officialListView.updateUI(songList: model.creatives)
    }
}

/// 首页-发现  新歌 /新碟 /数字专辑
class NewAlbumsCell: BaseViewCell, TagSwitchDelegate {
    
    class var identifier: String {
          return String(describing: self)
    }
    
    var newAlbumsView: PrivateCustomView!
    /// 新歌
    var newSongs = [Creative]()
    /// 新碟
    var newAlbums = [Creative]()
    /// 数字专辑
    var digitalAlbums = [Creative]()
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? AlbumNewSongModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        headerView = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
        headerView?.tagDelegate = self
        newAlbumsView = PrivateCustomView(frame: CGRect.zero)
        self.contentView.addSubview(headerView!)
        self.contentView.addSubview(newAlbumsView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.newAlbumsView.frame = CGRect(x: 0, y: (headerView?.frame.maxY)!, width: self.bounds.width, height: self.bounds.height - (headerView?.frame.maxY)!)
    }
    
    func setupUI(model: AlbumNewSongModel) {
        var titles:Array<String> = []
        /// 整理 新歌 / 新碟 / 数字专辑
        for creative in model.creatives {
            if !titles.contains((creative.uiElement?.mainTitle!.title)!) {
                titles.append((creative.uiElement?.mainTitle!.title)!)
            }
        }
        headerView!.setupUIWithMutiTags(titles: titles, btnName: "更多", type: .rightArrow)
        
        /// 拆分新歌/新碟/数字专辑
        newSongs.removeAll()
        newAlbums.removeAll()
        digitalAlbums.removeAll()
        
        splitDataToSongsAlbum(from: model)
        /// 默认新歌
        if newSongs.count > 0 {
            self.newAlbumsView.updateUI(privateData: newSongs)
        } else {
            print("模型数据解析失败")
        }
    }
    
    /// 切换内容  0: 新歌  2：新碟  4： 数字专辑
    func switchContent(to index: Int) {
        if index == 0 {
            self.newAlbumsView.updateUI(privateData: newSongs)
        } else if index == 2 {
            self.newAlbumsView.updateUI(privateData: newAlbums)
        } else if index == 4 {
            self.newAlbumsView.updateUI(privateData: digitalAlbums)
        }
    }
    
    /// 拆分数据
    func splitDataToSongsAlbum(from model: AlbumNewSongModel) {
        for item in model.creatives {
            if item.creativeType == "NEW_SONG_HOMEPAGE" {
                newSongs.append(item)
            } else if item.creativeType == "NEW_ALBUM_HOMEPAGE" {
                newAlbums.append(item)
            } else if item.creativeType == "DIGITAL_ALBUM_HOMEPAGE" {
                digitalAlbums.append(item)
            }
        }
    }
    
    // 视图切换
    func tagSwitchTo(to index: Int) {
        switchContent(to: index)
    }
}


/// 首页-发现  播客推荐
class VoiceCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var voiceListView: CardCollectionView!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? VoiceListRcmdModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        headerView = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
        voiceListView = CardCollectionView(frame: CGRect.zero)
        self.contentView.addSubview(headerView!)
        self.contentView.addSubview(voiceListView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.voiceListView.frame = CGRect(x: 0, y: (headerView?.frame.maxY)!, width: self.bounds.width, height: self.bounds.height - (headerView?.frame.maxY)!)
    }
    
    func setupUI(model: VoiceListRcmdModel) {
        headerView!.setupUI(title: (model.uiElement?.subTitle!.title)!, btnName: (model.uiElement?.button!.text)!, type: .rightArrow)
        self.voiceListView.updateUI(songList: model.creatives)
    }
}

/// 首页-发现  广播 24 小时
class PodcastCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var podCastView: PodcastView!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? Podcast24Model else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        headerView = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
        podCastView = PodcastView(frame: CGRect.zero)
        self.contentView.addSubview(headerView!)
        self.contentView.addSubview(podCastView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.podCastView.frame = CGRect(x: 0, y: (headerView?.frame.maxY)!, width: self.bounds.width, height: self.bounds.height - (headerView?.frame.maxY)!)
    }
    
    func setupUI(model: Podcast24Model) {
        headerView!.setupUI(title: (model.uiElement?.subTitle!.title)!, btnName: "", type: .none)
        self.podCastView.updateUI(voiceList: model.creatives)
    }
}


/// 首页-发现  视频合辑
class VideoPlayListCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var videoListView: CardCollectionView!
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? VideoPlaylistModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        videoListView = CardCollectionView(frame: CGRect.zero)
        headerView = JJTableViewHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: HEADVIEW_H))
        self.contentView.addSubview(headerView!)
        self.contentView.addSubview(videoListView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.videoListView.frame = CGRect(x: 0, y: (headerView?.frame.maxY)!, width: self.bounds.width, height: self.bounds.height - (headerView?.frame.maxY)!)
    }
    
    func setupUI(model: VideoPlaylistModel) {
        headerView!.setupUI(title: (model.uiElement?.subTitle!.title)!, btnName: (model.uiElement?.button!.text)!, type: .rightArrow)
        self.videoListView.updateUI(songList: model.creatives)
    }
}
