//
//  UIViewExtension.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/6/16.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ rect: CGRect, corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /*
    * 获取字符串边框
    */
   func getStrBoundRect(str:String,font:UIFont,constrainedSize:CGSize,
                             option:NSStringDrawingOptions = NSStringDrawingOptions.usesLineFragmentOrigin)->CGRect{
        let attr = [NSAttributedString.Key.font:font]
        let rect = str.boundingRect(with: constrainedSize, options: NSStringDrawingOptions.usesFontLeading, attributes:attr , context: nil)
        let bound: CGRect = CGRect(x: 0, y: 0, width: rect.width + 15, height: rect.height)
        return bound
    }
}
