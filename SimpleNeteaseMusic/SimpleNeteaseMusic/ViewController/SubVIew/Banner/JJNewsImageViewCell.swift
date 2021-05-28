//
//  JJNewsImageViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/10/14.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

class JJNewsImageViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置样式
        imageView.frame = CGRect.zero
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        self.contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.frame
//        imageView.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.top.equalToSuperview().offset(20)
//            make.bottom.equalToSuperview().offset(-20)
//        }
    }
    
    func setupUI(imageName: String?, imageUrl: String?, placeholderImage: UIImage?, contentMode: ContentMode) {
        // 设置模式
        imageView.contentMode = .scaleAspectFill
        // 加载网络图片
        if imageName != nil {
            imageView.image = UIImage(named: imageName!)
        } else if imageUrl != nil {
            imageView.kf.setImage(with: URL(string: imageUrl!), placeholder: placeholderImage, options: nil, progressBlock: nil) { (reslt) in
                
            }
        }
    }
}
