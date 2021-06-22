//
//  VoiceListCell.swift
//  SimpleNeteaseMusic
//
//  Created by snaigame on 2021/6/6.
//  Copyright © 2021 shenjie. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class PodcastViewCell: UICollectionViewCell {
    
    lazy var albumCover: UIImageView! = {
        let cover = UIImageView()
        cover.backgroundColor = UIColor.black
        cover.contentMode = .scaleAspectFit
        return cover
    }()
    
    lazy var albumDesc: UILabel! = {
        let descLabel = UILabel()
        descLabel.backgroundColor = UIColor.clear
        descLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        return descLabel
    }()
    
    lazy var playIcon: UIImageView! = {
        let icon = UIImageView(image: UIImage(named: "play"))
        return icon
    }()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height: CGFloat = self.frame.size.height
        let width: CGFloat = self.frame.size.width
        
        let descHeight: CGFloat = height * (1/4)
        
        self.addSubview(self.albumCover)
        self.albumCover.addSubview(self.playIcon)
        self.addSubview(self.albumDesc)
    
        self.albumCover.snp.makeConstraints { (make) in
            make.width.equalTo(width - 10)
            make.height.equalTo(width - 10)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        self.albumCover.layer.cornerRadius = (width - 10) / 2
        self.albumCover.layer.masksToBounds = true
        
        self.playIcon.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.albumDesc.snp.makeConstraints { (make) in
            make.width.equalTo(width - 10)
            make.height.equalTo(descHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.albumCover.snp.bottom).offset(5)
        }
    }
    
    /// 更新视图
    /// - Parameters:
    ///   - coverUrl: 封面url
    ///   - desc: 描述
    func updateUI(coverUrl: String, desc: String) -> Void {
        self.albumDesc.text = "";
        if coverUrl != "" {
            let cache = KingfisherManager.shared.cache
            let optionsInfo = [KingfisherOptionsInfoItem.targetCache(cache)]
            self.albumCover.kf.setImage(with: URL(string: coverUrl), placeholder: nil, options: optionsInfo, progressBlock: nil) { (reslt) in
                
            }
        }
        self.albumDesc.text = desc
    }
}
