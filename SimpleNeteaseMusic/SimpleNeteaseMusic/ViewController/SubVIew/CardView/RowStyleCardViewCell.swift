//
//  RowStyleCardViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/2.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SnapKit

// 默认的行高
let ROW_HEIGHT:Float = 60.0

class RowStyleCardViewCell: UICollectionViewCell {
    lazy var rowView1: RowStyleView = {
       let view = RowStyleView()
        return view
    }()
    
    lazy var rowView2: RowStyleView = {
       let view = RowStyleView()
        return view
    }()
    
    
    lazy var rowView3: RowStyleView = {
       let view = RowStyleView()
        return view
    }()

    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        // 构建 Cell UI
        self.addSubview(rowView1)
        self.addSubview(rowView2)
        self.addSubview(rowView3)
        
        // 每个 row 的行高
        let rowHeight: Float = Float(self.frame.size.height) / 3
        
        // 约束
        self.rowView1.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(rowHeight)
        }
        
        self.rowView2.snp.makeConstraints { (make) in
            make.top.equalTo(self.rowView1.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(rowHeight)
        }
        
        self.rowView3.snp.makeConstraints { (make) in
            make.top.equalTo(self.rowView2.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(rowHeight)
        }
    }
}
