//
//  RankDetailViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/1/6.
//  Copyright © 2021 shenjie. All rights reserved.
//

import UIKit

class RankDetailViewCell: UICollectionViewCell {
    
    // 排行榜名目
    lazy var headTitle: UIView = {
       let view = UIView()
        let subRankBtn = UIButton(type: .custom)
        view.addSubview(subRankBtn)
        return view
    }()
    
    // 第一名
    lazy var rowView1: RowStyleView = {     
//        let view = RowStyleView.initRowViewWithHeaderStyle(<#T##self: RowStyleView##RowStyleView#>)
//        RowStyleView(style: <#T##RowStyle#>)
        let view: RowStyleView = RowStyleView()
        view.updateUI(mImgUrl: "", mSongname: "", mAuthor: "", mSongDetail: "")
        return view
    }()
    
    // 第二名
    lazy var rowView2: RowStyleView = {
       let view = RowStyleView()
        view.updateUI(mImgUrl: "", mSongname: "", mAuthor: "", mSongDetail: "")
        return view
    }()
    
    // 第三名
    lazy var rowView3: RowStyleView = {
       let view = RowStyleView()
        view.updateUI(mImgUrl: "", mSongname: "", mAuthor: "", mSongDetail: "")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifeycle
extension RankDetailViewCell {
    
    /* 布局尺寸必须在 layoutSubViews 中, 否则获取的 size 不正确 **/
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
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

// MARK: - Configuration
extension RankDetailViewCell {
    
    private func configUI() {
        // 构建 Cell UI
        self.addSubview(rowView1)
        self.addSubview(rowView2)
        self.addSubview(rowView3)
    }
}
