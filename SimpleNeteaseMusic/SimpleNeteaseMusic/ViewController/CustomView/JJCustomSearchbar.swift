//
//  JJCustomSearchbar.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/9/14.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

class JJCustomSearchbar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.searchTextField.placeholder = "has not been"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func adjustPosition() {
        var frame :CGRect
        frame = self.searchTextField.frame
        // 获取 placeholder 大小
        let r = self.searchTextField.placeholderRect(forBounds: self.searchTextField.bounds)
        let offset = UIOffset(horizontal: (frame.size.width - r.width - 40)/2, vertical: 0)
        self.setPositionAdjustment(offset, for: .search)
    }
}
