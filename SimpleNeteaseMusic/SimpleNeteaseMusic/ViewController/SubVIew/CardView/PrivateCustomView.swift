//
//  RowStyleCollectionView.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/4.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

let JJPrivateCustomViewID = "JJPrivateCustomViewID"

class PrivateCustomView: UIView {
            
    // 默认间隔
    fileprivate var horizonSpace: CGFloat = 10.0
    
    // 默认上边距
    fileprivate var marginTop: CGFloat = 10.0
    
    // 默认下边距
    fileprivate var marginButtom: CGFloat = 10.0
    
    // 私人定制数据
    fileprivate var privateListData: [Creative]!
    
    // 布局 layout
    private lazy var flowLayout: RowStyleLayout = {
        let flowLayout = RowStyleLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: marginTop, left: marginButtom, bottom: marginButtom, right: marginButtom)
//        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        return flowLayout
    }()
    
    /// 歌单的视图
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.register(PrivateCustomItem.self, forCellWithReuseIdentifier: JJPrivateCustomViewID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.bounces = false

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
        self.collectionView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        // 设置 item size 大小
        flowLayout.itemSize = CGSize(width: width - 40 * scaleW, height: height - 20 * scaleH)
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

