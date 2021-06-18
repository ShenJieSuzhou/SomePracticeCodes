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
    
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置样式
        self.contentView.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.bounds
        /// 四边角设置圆角
        self.imageView.roundCorners(self.imageView.bounds.inset(by: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)), corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
    }
    
    func setupUI(imageName: String?, imageUrl: String?, placeholderImage: UIImage?, contentMode: ContentMode) {
        // 设置模式
        self.imageView.contentMode = .scaleAspectFill
        // 加载网络图片
        if imageName != nil {
            self.imageView.image = UIImage(named: imageName!)
        } else if imageUrl != nil {
            let cache = KingfisherManager.shared.cache
            let optionsInfo = [KingfisherOptionsInfoItem.targetCache(cache),
                                KingfisherOptionsInfoItem.processor(RoundCornerImageProcessor(cornerRadius: 10))]
            self.imageView.kf.setImage(with: URL(string: imageUrl!), placeholder: placeholderImage, options: optionsInfo, progressBlock: nil) { (reslt) in
                
            }
        }
    }
}
