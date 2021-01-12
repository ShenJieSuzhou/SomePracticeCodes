//
//  RankDetailViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/1/6.
//  Copyright © 2021 shenjie. All rights reserved.
//

import UIKit

class RankDetailItem: UICollectionViewCell {
    
    // stackView
    private var stack: UIStackView!
    
    // 排行榜标题 View
    private lazy var headTitle: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // 排行榜标题按钮
    private lazy var subRankBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.titleLabel?.textColor = .darkModeTextColor
        return button;
    }()
    
    // 排行榜标题
    private var title: String!
    
    // 排行榜数据
    private var rankDataList: [SongModel]!
    
    // 排行榜榜单列表
    private var rankRowViews: [RowStyleView]!
    
    // 默认排行榜单个 item 的高度为 40
    public var height: CGFloat = 40.0
    
    // 更新数据，并重绘界面
    public func updateRankItem(rank: [SongModel], headTitle: String) {
        rankDataList = rank
        title = headTitle
        subRankBtn.setTitle(title, for: .normal)
        
        createRowStyleView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifeycle
extension RankDetailItem {
    
    /* 布局尺寸必须在 layoutSubViews 中, 否则获取的 size 不正确 **/
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        // 进行约束
        headTitle.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(height)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        subRankBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(height)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        stack.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(headTitle.snp.bottom)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Configuration
extension RankDetailItem {
    
    private func configUI() {
        // 构建 UI
        self.backgroundColor = .darkModeCellColor
        self.layer.cornerRadius = 10
        
        headTitle.addSubview(subRankBtn)
        self.contentView.addSubview(headTitle)
    }
    
    private func createRowStyleView() {
        // 宽度
        let width: CGFloat = self.frame.size.width - JJINTERVAL * 2
        
        rankRowViews = [RowStyleView]()
        rankRowViews.removeAll()
        
        for listItem in rankDataList {
            let rowView = RowStyleView(frame: CGRect(x: 0, y: 0, width: Double(width), height: Double(20)), style: .NoneStyle)
            rowView.setUpRowViewWithDefultStyle(image: listItem.image, order: listItem.order, songName: listItem.songName, singer: listItem.singer, style: .NoneStyle, extra: listItem.extra)
            rankRowViews.append(rowView)
        }
        
        stack = UIStackView(arrangedSubviews: rankRowViews)
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fillEqually
        self.contentView.addSubview(stack)
    }
}
