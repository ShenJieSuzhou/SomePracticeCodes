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
    
    // 私人定制数据
    fileprivate var privateListData: [PrivateCustomModel]!
    
    // 布局 layout
    private lazy var flowLayout: UICollectionViewFlowLayout = {
      let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: marginTop, left: marginTop, bottom: marginButtom, right: marginButtom)
        flowLayout.scrollDirection = .horizontal
      return flowLayout
    }()
    
    /// 歌单的视图
    private var collectionView: UICollectionView!
    
    convenience init(frame: CGRect ,data: [PrivateCustomModel]) {
        self.init(frame:frame)
        privateListData = data
        configUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        let result:PrivateCustomModel = self.privateListData![indexPath.row]
        cell.height = rowHeight
        cell.updateUI(data: result.privateList)
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
       
        if privateListData == nil {
            width = self.frame.width
            height = self.frame.height
        } else {
            width = self.frame.width
            height = caculateViewHeight()
        }
        
        // 设置 frame
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        // 设置 item size 大小
        flowLayout.itemSize = CGSize(width: width - 40, height: height - marginTop - marginButtom)
        
        // 设置大小约束
        self.collectionView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    
    // 计算视图的高度
    public func caculateViewHeight() -> CGFloat {
        // 如果没有数据则高度为 0
        if privateListData.isEmpty {
            return 0
        }
        
        let rows: Int = privateListData.count
        // 总的高度
        let totalHeight: CGFloat = rowHeight * CGFloat(rows) + horizonSpace * CGFloat(rows + 1) + marginTop + marginButtom
        
        return totalHeight
    }
}

// MARK - Configuration UI
extension PrivateCustomView {
    
    // 构建 UI
    private func configUI() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), collectionViewLayout: flowLayout)
        collectionView.register(PrivateCustomItem.self, forCellWithReuseIdentifier: JJPrivateCustomViewID)
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
    
    // 更新数据
    public func updateUI(privateData: [PrivateCustomModel]){
        
        self.privateListData = privateData
        self.layoutIfNeeded()
    }
}
