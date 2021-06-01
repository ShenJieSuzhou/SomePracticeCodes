//
//  UIImageViewExtension.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/6/1.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func maskWith(color: UIColor) {
        guard let tempImage = image?.withRenderingMode(.alwaysTemplate) else { return }
        image = tempImage
        tintColor = color
    }
}
