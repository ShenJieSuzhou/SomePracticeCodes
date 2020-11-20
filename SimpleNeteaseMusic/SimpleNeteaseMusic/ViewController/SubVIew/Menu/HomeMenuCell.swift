//
//  HomeMenuCell.swift
//  SimpleNeteaseMusic
//
//  Created by snaigame on 2020/11/16.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import Foundation

class HomeMenuCell: UICollectionViewCell {
    var menuLayer = UIView()
    var menuIcon = UIImageView()
    var menuText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.menuLayer)
        self.menuLayer.addSubview(self.menuIcon)
        self.contentView.addSubview(self.menuText)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.menuLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height - 30)
        self.menuIcon.frame = CGRect(x: (self.frame.size.width - 30) / 2, y: (self.frame.size.width - 30) / 2, width: 30, height: 30)
        self.menuText.frame = CGRect(x: 0, y: self.frame.size.height - 30, width: self.frame.size.width, height: 30)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(imageName: String, title: String) -> Void {
        self.menuIcon.image = UIImage(named: "music")
        self.menuText.text = title
    }
    
    
}

