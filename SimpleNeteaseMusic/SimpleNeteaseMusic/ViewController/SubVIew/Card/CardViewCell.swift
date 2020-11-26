//
//  CardViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/26.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SnapKit

class CardViewCell: UICollectionViewCell {
    lazy var albumCover: UIImageView! = {
        let cover = UIImageView()
        cover.backgroundColor = UIColor.black
        
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
        
        let coverHeight: CGFloat = height * (3/4)
        let descHeight: CGFloat = height * (1/4)
        
        self.addSubview(self.albumCover)
        self.albumCover.addSubview(self.playIcon)
        self.albumCover.addSubview(self.albumViews)
        self.addSubview(self.albumDesc)
    
        self.albumCover.snp.makeConstraints { (make) in
            make.width.equalTo(width - 20)
            make.height.equalTo(coverHeight)
            make.centerX.equalToSuperview()
        }
        
        self.albumDesc.snp.makeConstraints { (make) in
            make.width.equalTo(width - 20)
            make.height.equalTo(descHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.albumCover.snp.bottom).offset(5)
        }
        
    }
    
    
    func updateUI(coverUrl: String, desc: String, views: String) -> Void {
    
        
        
    }
}
