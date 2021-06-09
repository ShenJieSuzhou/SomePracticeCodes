//
//  UIButtonExtension.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/6/9.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func moveImageLeftTextCenter(imagePadding: CGFloat){
        guard let imageViewWidth = self.imageView?.frame.width else{return}
//        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
        self.contentHorizontalAlignment = .left
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imagePadding, bottom: 0.0, right: 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: imagePadding + imageViewWidth + imagePadding, bottom: 0.0, right: 0.0)
    }
    
    func moveImageRightTextCenter(imagePadding: CGFloat){
//        guard let imageViewWidth = self.imageView?.frame.width else{return}
        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
        self.contentHorizontalAlignment = .left
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: imagePadding, bottom: 0.0, right: 0.0)
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imagePadding + titleLabelWidth + imagePadding, bottom: 0.0, right: imagePadding)
    }
}


