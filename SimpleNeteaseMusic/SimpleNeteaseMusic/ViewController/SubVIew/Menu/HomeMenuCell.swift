//
//  HomeMenuCell.swift
//  SimpleNeteaseMusic
//
//  Created by snaigame on 2020/11/16.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import Kingfisher

class HomeMenuCell: UICollectionViewCell {
    
    lazy var menuLayer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkModeMenuColor
        return view
    }()
    
    lazy var menuIcon: UIImageView = {
        let mIcon = UIImageView()
        mIcon.tintColor = UIColor.dragonBallColor
        return mIcon
    }()
    
    lazy var menuText: UILabel = {
        let mText = UILabel()
        mText.textColor = UIColor.darkModeTextColor
        mText.textAlignment = .center
        mText.font = UIFont.systemFont(ofSize: 14)
        return mText
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(self.menuLayer)
        self.menuLayer.addSubview(self.menuIcon)
        self.contentView.addSubview(self.menuText)
        
        self.menuLayer.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(self.frame.size.width * 0.6)
            make.height.equalTo(self.frame.size.width * 0.6)
        }
        
        self.menuIcon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(self.frame.size.width * 0.6)
            make.height.equalTo(self.frame.size.width * 0.6)
        }
        
        self.menuText.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(self.frame.size.width * 0.4)
            make.width.equalTo(self.frame.size.width)
        }
        
        // 设置菜单圆角
        self.menuLayer.layer.cornerRadius = self.frame.size.width * 0.6 * 0.5
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(imageUrl: String, title: String) -> Void {
        let cache = KingfisherManager.shared.cache
        let imgModify = RenderingModeImageModifier(renderingMode: .alwaysTemplate)
        let optionsInfo = [KingfisherOptionsInfoItem.imageModifier(imgModify),
                        KingfisherOptionsInfoItem.targetCache(cache)]

        self.menuIcon.kf.setImage(with: URL(string: imageUrl), placeholder: nil, options: optionsInfo, completionHandler:  { ( result ) in
            
        })
        self.menuText.text = title
    }
}

