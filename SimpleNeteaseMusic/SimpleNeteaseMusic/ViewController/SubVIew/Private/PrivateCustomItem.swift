//
//  PrivateCustomItem.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/1/13.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class PrivateCustomItem: UICollectionViewCell {
    // stackView
    private var stack: UIStackView!
    
    // 私人定制数据
    private var privateDataList: [SongModel]!
    
    // 私人定制列表
    private var privateRowViews: [RowStyleView]!
    
    // 默认排行榜单个 item 的高度为 40
    public var height: CGFloat = 40.0

    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifeycle
extension PrivateCustomItem {
    
    /* 布局尺寸必须在 layoutSubViews 中, 否则获取的 size 不正确 **/
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        // 进行约束
        stack.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Configuration
extension PrivateCustomItem {
    
    private func createRowStyleView() {
        // 宽度
        let width: CGFloat = self.frame.size.width - JJINTERVAL * 2
        
        privateRowViews = [RowStyleView]()
        privateRowViews.removeAll()
        
        for listItem in privateDataList {
            let rowView = RowStyleView(frame: CGRect(x: 0, y: 0, width: Double(width), height: Double(20)), style: .SubTitleStyle)
            rowView.setUpRowViewWithSubTitleStyle(image: listItem.image, songName: listItem.songName, singer: listItem.singer, foreword: " privateRowViews = [RowStyleView]()", style: .SubTitleStyle, extra: "")
            privateRowViews.append(rowView)
        }
        
        stack = UIStackView(arrangedSubviews: privateRowViews)
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fillEqually
        self.contentView.addSubview(stack)
    }
    
    // 更新数据，并重绘界面
    public func updateUI(data: [SongModel]) {
        privateDataList = data
        createRowStyleView()
    }
}
