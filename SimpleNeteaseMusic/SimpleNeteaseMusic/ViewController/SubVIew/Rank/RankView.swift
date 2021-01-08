//
//  RankView.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/1/6.
//  Copyright © 2021 shenjie. All rights reserved.
//
//  排行榜
import UIKit
import Foundation

let JJRanktemCellId = "JJRanktemCellId"

class RankView: UIView {
    
    // 容器使用 UICOllectionVIew
    private var collectionView: UICollectionView!
    
    // 排行榜数据
    private var rankListData: [RankModel]!
    
    // layout 布局
    private lazy var layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    // 初始化接口
    convenience init(frame: CGRect, rankData: [RankModel]) {
        self.init(frame:frame)
        self.rankListData = rankData
        ConfigUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        collectionView.delegate = nil
        collectionView.dataSource = nil
    }
}

// MARK - LifeCycle
extension RankView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置 item size 大小
        layout.itemSize = CGSize(width: self.frame.size.width - 60, height: self.frame.size.height - 20)
        // 添加约束
        collectionView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}

// MARK - Configuration UI
extension RankView {
    
    private func ConfigUI() {
        // 构建排行榜视图
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(RankDetailItem.self, forCellWithReuseIdentifier: JJRanktemCellId)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.bounces = false
        
        self.addSubview(collectionView)
    }
}

// MARK - UICollectionViewDelegate
extension RankView: UICollectionViewDelegate{
    
}

// MARK - UICollectionViewDataSource
extension RankView: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJRanktemCellId, for: indexPath) as! RankDetailItem
        let result:RankModel = rankListData![indexPath.row]
        cell.updateRankItem(rank: result.rankList, headTitle: result.title)
        return cell
    }
}


