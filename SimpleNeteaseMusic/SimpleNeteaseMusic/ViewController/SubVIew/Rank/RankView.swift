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
    fileprivate var collectionView: UICollectionView!
    
    // 排行榜数据
    fileprivate var rankListData: [RankModel]!
    
    // layout 布局
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.minimumLineSpacing = 0
//        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: marginTop, left: 20, bottom: marginButtom, right: 20)
        flowLayout.scrollDirection = .horizontal

        return flowLayout
    }()
    
    // 高度
    public var height: CGFloat = 0
    
    // 宽度
    public var width: CGFloat = 0
    
    // 默认高度
    public var rowHeight: CGFloat = 45.0
    
    // 默认间隔
    fileprivate var horizonSpace: CGFloat = 10.0
    
    // 默认上边距
    fileprivate var marginTop: CGFloat = 10.0
    
    // 默认下边距
    fileprivate var marginButtom: CGFloat = 10.0
    
    // 初始化接口
    convenience init(frame: CGRect, rankData: [RankModel]) {
        self.init(frame:frame)
        self.rankListData = rankData
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        width = frame.size.width
        height = frame.size.height
        ConfigUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateUI(rankData: [RankModel]){
        rankListData = rankData
        self.layoutIfNeeded()
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
        
        if rankListData == nil {
            height = 0
        } else {
            height = caculateViewHeight()
        }

        // 设置 item size 大小
        layout.itemSize = CGSize(width: width - 40, height: height)
        
        // 添加约束
        collectionView.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(height + marginTop + marginButtom)
        }
    }
    
    // 计算视图的高度
    private func caculateViewHeight() -> CGFloat {
        // 如果没有数据则高度为 0
        if rankListData.isEmpty {
            return 0
        }
        
        // 获取排行榜的
        let model: RankModel = self.rankListData[0]
        // +1 是将头部的标题算进去
        let rows: Int = model.rankList.count + 1
        // 总的高度
        let totalHeight: CGFloat = rowHeight * CGFloat(rows) + horizonSpace * CGFloat(rows + 1)
        
        return totalHeight
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
        cell.height = rowHeight
        let result:RankModel = rankListData![indexPath.row]
        cell.updateRankItem(rank: result.rankList, headTitle: result.title)
        return cell
    }
}


