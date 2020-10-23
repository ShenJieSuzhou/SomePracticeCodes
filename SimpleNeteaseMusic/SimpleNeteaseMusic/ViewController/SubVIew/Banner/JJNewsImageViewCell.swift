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
        
        self.imageView.frame = self.bounds
        self.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(imageName: String?, imageUrl: String?, placeholderImage: UIImage?, contentMode: ContentMode) {
        
        self.imageView.contentMode = contentMode
        
        if imageName != nil {
            self.imageView.image = UIImage(named: imageName!)
        } else if imageUrl != nil {
//            self.imageView.kf.setImage(with: URL(string: imageUrl!), placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: nil){ (reslt) in
//
//            }
            
            self.imageView.kf.setImage(with: URL(string: imageUrl!), placeholder: placeholderImage, options: nil, progressBlock: nil) { (reslt) in
                
            }

//            self.imageView.kf.setImage(with: URL(string: imageUrl!), placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
