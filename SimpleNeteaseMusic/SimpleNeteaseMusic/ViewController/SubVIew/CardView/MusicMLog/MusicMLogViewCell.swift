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
        cover.backgroundColor = UIColor.clear
        return cover
    }()
    
    lazy var albumDesc: UILabel! = {
        let descLabel = UILabel()
        descLabel.backgroundColor = UIColor.clear
        descLabel.font = UIFont.systemFont(ofSize: 12)
        descLabel.numberOfLines = 0
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
        
        let descHeight: CGFloat = 30 * scaleH
        
        self.addSubview(self.albumCover)
        self.albumCover.addSubview(self.playIcon)
        self.albumCover.addSubview(self.viewsButton)
        self.addSubview(self.albumDesc)
    
        self.albumCover.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(height - descHeight - padding)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        self.albumCover.roundCorners(self.albumCover.frame, corners: [.allCorners], radius: 10)
        
        let viewsRect = self.getStrBoundRect(str: self.views!, font: self.viewsButton.titleLabel!.font, constrainedSize: CGSize.zero)
        let viewsW = viewsRect.width * 1.5
        let viewsH = viewsRect.height * 1.2
        self.viewsButton.frame = CGRect(x: self.albumCover.frame.width - viewsW - padding, y: padding, width: viewsW, height: viewsH)

        // 设置按钮样式
        self.viewsButton.moveImageLeftTextCenterWithTinySpace(imagePadding: 5)
        self.viewsButton.layer.cornerRadius = viewsW * 0.15
        
        self.albumDesc.snp.makeConstraints { (make) in
            make.width.equalTo(width)
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
    
//    /// 获取字符串边框
//    func getStrBoundRect(str:String,font:UIFont,constrainedSize:CGSize,
//                             option:NSStringDrawingOptions=NSStringDrawingOptions.usesLineFragmentOrigin) -> CGRect{
//        let attr = [NSAttributedString.Key.font:font]
//        let rect = str.boundingRect(with: constrainedSize, options: option, attributes:attr , context: nil)
//        return rect
//    }
}
