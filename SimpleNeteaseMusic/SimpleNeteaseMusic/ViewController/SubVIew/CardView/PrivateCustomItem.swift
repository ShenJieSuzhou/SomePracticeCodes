//
//  PrivateCustomItem.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/1/13.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

let marginSpace: CGFloat = 10

class PrivateCustomItem: UICollectionViewCell {
    // stackView
    private var stack: UIStackView!
    
    // 私人定制数据
    private var privateDataList: [ResourceElement]!
    
    // 私人定制列表
    private var privateRowViews: [RowStyleView]!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    }
}

// MARK: - Configuration
extension PrivateCustomItem {
    
    private func createRowStyleView() {
        // 宽度
        let width: CGFloat = self.frame.size.width
        // 高度
        let height: CGFloat = (self.frame.size.height - 20) / 3

        privateRowViews = [RowStyleView]()
        privateRowViews.removeAll()
        
        for listItem in privateDataList {
            let rowView = RowStyleView(frame: CGRect(x: 0, y: 0, width: Double(width), height: Double(height)), style: .SubTitleStyle)
            let artists = (listItem.resourceEXTInfo?.artists![0])! as ResourceEXTInfoArtist
            rowView.setUpRowViewWithSubTitleStyle(image: listItem.uiElement.image.imageURL, songName: listItem.uiElement.mainTitle.title, singer: artists.name, foreword: listItem.uiElement.subTitle?.title ?? "", style: .SubTitleStyle, extra: "")
            privateRowViews.append(rowView)
        }
        
        stack = UIStackView(arrangedSubviews: privateRowViews)
        stack.frame = self.bounds
        stack.spacing = marginSpace
        stack.axis = .vertical
        stack.distribution = .fillEqually
        self.contentView.addSubview(stack)
    }
    
    // 更新数据，并重绘界面
    public func updateUI(data: [ResourceElement]) {
        privateDataList = nil
        privateDataList = data
        if stack != nil {
            stack.removeFromSuperview()
        }
        createRowStyleView()
    }
}
