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
        
        imageView.frame = CGRect.zero
        self.contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = self.frame.size.width
        
        imageView.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setupUI(imageName: String?, imageUrl: String?, placeholderImage: UIImage?, contentMode: ContentMode) {
        
        imageView.contentMode = .scaleToFill
        
        if imageName != nil {
            imageView.image = UIImage(named: imageName!)
        } else if imageUrl != nil {
            imageView.kf.setImage(with: URL(string: imageUrl!), placeholder: placeholderImage, options: nil, progressBlock: nil) { (reslt) in
                
            }
        }
    }
}
