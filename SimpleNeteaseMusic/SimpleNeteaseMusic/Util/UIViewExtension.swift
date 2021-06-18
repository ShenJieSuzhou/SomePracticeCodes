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
}
