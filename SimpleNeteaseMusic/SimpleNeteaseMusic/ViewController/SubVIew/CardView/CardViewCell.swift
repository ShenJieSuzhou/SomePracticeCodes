//
//  CardViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/26.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CardViewCell: UICollectionViewCell {
    /// 封面
    lazy var albumCover: UIImageView! = {
        let cover = UIImageView()
        cover.backgroundColor = UIColor.clear
        cover.contentMode = .scaleAspectFill
        return cover
    }()
    
    /// 描述
    lazy var albumDesc: UILabel! = {
        let descLabel = UILabel()
        descLabel.backgroundColor = UIColor.clear
        descLabel.font = UIFont.systemFont(ofSize: 12)
        descLabel.numberOfLines = 0
        return descLabel
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.addSubview(self.albumCover)
        self.albumCover.addSubview(self.viewsButton)
        self.addSubview(self.albumDesc)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height: CGFloat = self.bounds.height
        let width: CGFloat = self.bounds.width
        
        let descHeight: CGFloat = height * (1/4)
        
        // 封面样式设置
        self.albumCover.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(width)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        self.albumCover.roundCorners(self.albumCover.bounds, corners: [.allCorners], radius: 10)
       
        // 设置按钮样式
        let viewsRect = self.getStrBoundRect(str: self.views!, font: self.viewsButton.titleLabel!.font, constrainedSize: CGSize(width: 40, height: 20))
        let viewsW = viewsRect.width * 1.5
        let viewsH = viewsRect.height * 1.2
        self.viewsButton.frame = CGRect(x: self.albumCover.frame.width - viewsW - padding, y: padding, width: viewsW, height: viewsH)
        self.viewsButton.moveImageLeftTextCenterWithTinySpace(imagePadding: 5)
        self.viewsButton.roundCorners(self.viewsButton.bounds, corners: [.allCorners], radius: viewsW * 0.2)
        
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
        self.views = views
        let count:Int = Int(views)!
        if count % 100000 == 0 {
            self.viewsButton.setTitle(String(count), for: .normal)
        } else {
            let value: String = String(count / 10000)
            self.viewsButton.setTitle(String(value + "万"), for: .normal)
        }
    }
}
