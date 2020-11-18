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
    var menuIcon = UIImageView()
    var menuText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.menuIcon)
        self.contentView.addSubview(self.menuText)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(imageName: String, title: String) -> Void {
        
    }
}

