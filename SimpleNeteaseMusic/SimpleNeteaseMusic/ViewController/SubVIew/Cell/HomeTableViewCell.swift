//
//  HomeTableViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class BannerCell: UITableViewCell {
     
}


/// UITableViewCell 的基类
class BaseViewCell: UITableViewCell {
    
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
        rcmdPlayListView = CardCollectionView(frame: CGRect.zero)
        self.contentView.addSubview(rcmdPlayListView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUI(model: PlaylistRcmdModel) {
        self.rcmdPlayListView.frame = model.frame
        self.rcmdPlayListView.updateUI(hotList: model.creatives)
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
        rcmdStyleView = PrivateCustomView(frame: CGRect.zero)
        self.contentView.addSubview(rcmdStyleView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUI(model: StyleRcmdModel) {
        self.rcmdStyleView.frame = model.frame
        self.rcmdStyleView.updateUI(privateData: model.creatives)
    }
}
