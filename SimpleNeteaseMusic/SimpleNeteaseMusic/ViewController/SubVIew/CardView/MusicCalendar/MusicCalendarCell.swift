//
//  MusicCalendarViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/6/4.
//  Copyright © 2021 shenjie. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MusicCalendarViewCell: UICollectionViewCell {
    
    /// 日历容器
    lazy var container: UIView! = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    /// cover image
    lazy var coverImage: UIImageView! = {
        let cover = UIImageView()
        cover.backgroundColor = UIColor.clear
        cover.contentMode = .scaleAspectFill
        return cover
    }()
    
    /// titile
    lazy var titleL: UILabel! = {
        let descLabel = UILabel()
        descLabel.backgroundColor = UIColor.clear
        descLabel.tintColor = UIColor.darkModeTextColor
        descLabel.font = UIFont.systemFont(ofSize: 14)
        return descLabel
    }()
        
    /// 日期
    lazy var dateL: UILabel! = {
        let dateLabel = UILabel()
        dateLabel.backgroundColor = UIColor.clear
        dateLabel.tintColor = UIColor.lightGray
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        return dateLabel
    }()
    
    /// 标签
    lazy var tagL: UILabel! = {
        let tagLabel = UILabel()
        tagLabel.backgroundColor = UIColor.clear
        tagLabel.tintColor = UIColor.darkModeTextColor
        tagLabel.font = UIFont.systemFont(ofSize: 12)
        return tagLabel
    }()
    
    /// 提醒闹钟按钮
    lazy var clockBtn: UIButton! = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.clear
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.container)
        self.addSubview(self.coverImage)
        
        self.container.addSubview(self.dateL)
        self.container.addSubview(self.tagL)
        self.container.addSubview(self.titleL)
        self.container.addSubview(self.clockBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let marginLeft: CGFloat = 10
        let marginRight: CGFloat = 10
        let marginTop: CGFloat = 5
        let height: CGFloat = self.frame.size.height
        let width: CGFloat = self.frame.size.width
        let clockW: CGFloat = 25
        let clockH: CGFloat = 25
        
        /// 计算日期的尺寸
        let rect = getStrBoundRect(str: "今天", font: UIFont.systemFont(ofSize: 12), constrainedSize: CGSize(width: 14, height: 40))
        
        self.container.snp.makeConstraints { (make) in
            make.width.equalTo(width - (height - marginTop * 2) - marginLeft - marginRight)
            make.height.equalTo(height - marginTop * 2)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(marginLeft)
        }
        
        self.coverImage.snp.makeConstraints { (make) in
            make.width.equalTo(height - marginTop * 2)
            make.height.equalTo(height - marginTop * 2)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-marginRight)
        }
        
        self.dateL.snp.makeConstraints { (make) in
            make.width.equalTo(rect.width + 20)
            make.height.equalTo((height - marginTop * 2) / 2)
            make.top.equalToSuperview().offset(-5)
            make.left.equalToSuperview()
        }

        self.tagL.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo((height - marginTop * 2) / 2)
            make.top.equalToSuperview().offset(-5)
            make.left.equalTo(self.dateL.snp.right).offset(5)
        }

        self.titleL.snp.makeConstraints { (make) in
            make.width.equalTo(width - (height - marginTop * 2) - marginLeft - marginRight - clockW)
            make.height.equalTo(height - marginTop * 2)
            make.bottom.equalToSuperview().offset(5)
            make.left.equalToSuperview()
        }

        self.clockBtn.snp.makeConstraints { (make) in
            make.width.equalTo(clockW)
            make.width.equalTo(clockH)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func updateUI(tag: String, title: String, coverUrl: String) -> Void {
        if coverUrl != "" {
            self.coverImage.kf.setImage(with: URL(string: coverUrl), placeholder: nil, options: nil, progressBlock: nil) { (reslt) in
                
            }
        }
        
        if tag != "" {
            self.dateL.text = "今天"
        } else {
            self.dateL.text = "明天"
        }
        
        self.tagL.text = tag
        self.titleL.text = title
    }
}
