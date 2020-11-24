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
        self.menuLayer.frame = CGRect(x: (self.frame.size.width - self.frame.size.width * 0.8) / 2, y: 0, width: self.frame.size.width * 0.8, height: self.frame.size.width * 0.8)
        self.menuLayer.backgroundColor = UIColor.black
        // 设置圆角
        self.setCornersRadius(self.menuLayer, radius: self.menuLayer.frame.width/2, roundingCorners: [[.topLeft, .topRight, .bottomLeft, .bottomRight]])
        
        
        self.menuIcon.frame = CGRect(x: (self.menuLayer.frame.width - 30) / 2, y: (self.menuLayer.frame.width - 30) / 2, width: 30, height: 30)
        self.menuText.frame = CGRect(x: 0, y: self.frame.size.height - 40, width: self.frame.size.width, height: 30)
        self.menuText.textColor = UIColor.black
        self.menuText.textAlignment = .center
        self.menuText.font = UIFont.systemFont(ofSize: 18)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(imageName: String, title: String) -> Void {
        self.menuIcon.image = UIImage(named: "music")
        self.menuText.text = title
    }
    
    func setCornersRadius(_ view: UIView!, radius:CGFloat, roundingCorners: UIRectCorner) -> Void {
        if view == nil {
            return
        }
        
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        maskLayer.shouldRasterize = true
        maskLayer.rasterizationScale = UIScreen.main.scale
        
        view.layer.mask = maskLayer
    }
}

