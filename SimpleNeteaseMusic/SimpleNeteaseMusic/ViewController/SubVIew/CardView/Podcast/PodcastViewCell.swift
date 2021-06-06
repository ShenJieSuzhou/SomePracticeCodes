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
    
    lazy var albumViews: UILabel! = {
        let views = UILabel()
        
        return views
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height: CGFloat = self.frame.size.height
        let width: CGFloat = self.frame.size.width
        
        let descHeight: CGFloat = height * (1/4)
        
        self.addSubview(self.albumCover)
        self.albumCover.addSubview(self.playIcon)
        self.albumCover.addSubview(self.albumViews)
        self.addSubview(self.albumDesc)
    
        self.albumCover.snp.makeConstraints { (make) in
            make.width.equalTo(width - 10)
            make.height.equalTo(width - 10)
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
    
    func updateUI(coverUrl: String, desc: String) -> Void {
        if coverUrl != "" {
            self.albumCover.kf.setImage(with: URL(string: coverUrl), placeholder: nil, options: nil, progressBlock: nil) { (reslt) in
                
            }
        }
        
        self.albumDesc.text = desc
    }
}
