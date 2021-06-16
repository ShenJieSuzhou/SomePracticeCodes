//
//  MusicMLogViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/6/3.
//  Copyright © 2021 shenjie. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MusicMLogViewCell: UICollectionViewCell {
    lazy var albumCover: UIImageView! = {
        let cover = UIImageView()
        cover.backgroundColor = UIColor.black
        cover.contentMode = .scaleAspectFill
        return cover
    }()
    
    lazy var albumDesc: UILabel! = {
        let descLabel = UILabel()
        descLabel.backgroundColor = UIColor.red
        return descLabel
    }()
    
    lazy var playIcon: UIImageView! = {
        let icon = UIImageView()
        
        return icon
    }()
    
    /// 阅读量
    var views: String?
    
    /// 内边距
    let padding: CGFloat = 5
    
    /// 阅读量按钮
    lazy var viewsButton: UIButton! = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.backgroundColor = UIColor(red: 182/255, green: 182/255, blue: 182/255, alpha: 0.6)
        button.setImage(UIImage(named: "Views"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height: CGFloat = self.frame.size.height
        let width: CGFloat = self.frame.size.width
        
        let descHeight: CGFloat = height * (1/4)
        
        self.addSubview(self.albumCover)
        self.albumCover.addSubview(self.playIcon)
//        self.albumCover.addSubview(self.albumViews)
        self.addSubview(self.albumDesc)
    
        self.albumCover.snp.makeConstraints { (make) in
            make.width.equalTo(width - 10)
            make.height.equalTo(width + 10)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        self.albumDesc.snp.makeConstraints { (make) in
            make.width.equalTo(width - 10)
            make.height.equalTo(descHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.albumCover.snp.bottom).offset(5)
        }
    }
    
    func updateUI(coverUrl: String, desc: String, views: String) -> Void {
        if coverUrl != "" {
            let radius = albumCover.frame.width * 0.5
            let cache = KingfisherManager.shared.cache
            let optionsInfo = [KingfisherOptionsInfoItem.targetCache(cache),
                               KingfisherOptionsInfoItem.processor(RoundCornerImageProcessor(cornerRadius: radius))]
            self.albumCover.kf.setImage(with: URL(string: coverUrl), placeholder: nil, options: optionsInfo, progressBlock: nil) { (reslt) in
                
            }
        }
        
        self.albumDesc.text = desc
//        self.albumViews.text = views
    }
}
