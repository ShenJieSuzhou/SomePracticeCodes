//
//  RowStyleCollectionView.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/4.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

let JJPrivateCustomViewID = "JJPrivateCustomViewID"

/// 通用的卡片滚动视图，该控件适用于多行内容的显示
class PrivateCustomView: UIView {
            
    // 默认间隔
    fileprivate var margin: CGFloat = 10.0
    
    // 默认上边距
    fileprivate var marginTop: CGFloat = 10.0
    
    // 默认下边距
    fileprivate var marginButtom: CGFloat = 10.0
    
    // 私人定制数据
    fileprivate var privateListData: [Creative]!
    
    // 布局 layout
    private lazy var flowLayout: RowStyleLayout = {
        let flowLayout = RowStyleLayout()
        flowLayout.sectionInset = UIEdgeInsets.init(top: -20, left: margin, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()
    
    /// 歌单的视图
    private lazy var collectionView: UICollectionView = {
        let collectionV = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionV.register(PrivateCustomItem.self, forCellWithReuseIdentifier: JJPrivateCustomViewID)
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.scrollsToTop = false
        collectionV.backgroundColor = UIColor.clear
        collectionV.bounces = false
        return collectionV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
    }
}

extension  PrivateCustomView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension  PrivateCustomView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return privateListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJPrivateCustomViewID, for: indexPath) as! PrivateCustomItem
        let result = self.privateListData![indexPath.row] as Creative
        cell.updateUI(data: result.resources!)
        cell.setNeedsLayout()
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK - LifeCycle
extension PrivateCustomView {
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        let height: CGFloat = self.frame.size.height
        let width: CGFloat = self.frame.size.width
        
        // 设置 frame
        self.collectionView.frame = self.bounds
        // 设置 item size 大小
        flowLayout.itemSize = CGSize(width: width - 40 * scaleW, height: height - margin * 2)
    }
}

// MARK - Configuration UI
extension PrivateCustomView {
    // 更新数据
    public func updateUI(privateData: [Creative]){
        self.privateListData = nil
        self.privateListData = privateData
        self.collectionView.reloadData()
    }
}

