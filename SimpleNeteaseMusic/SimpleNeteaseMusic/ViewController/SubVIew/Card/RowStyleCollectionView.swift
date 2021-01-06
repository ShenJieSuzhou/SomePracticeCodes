//
//  RowStyleCollectionView.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/4.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

let JJRowStyleCardID = "JJRowStyleCardID"

class RowStyleCollectionView: UIView {
    
//    // view width
//    var screen_width:CGFloat =
    
//    // 数据 data
//    var privateSongList:[] = {
//
//    }
    
    // 布局 layout
    lazy var rowStyleFlowLayout: UICollectionViewFlowLayout = {
      let flowLayout = UICollectionViewFlowLayout()
        let space = CGFloat.scaleW(20)
        flowLayout.itemSize = CGSize(width: self.frame.size.width - space(), height: self.frame.size.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      return flowLayout
    }()

    
    /// 歌单的视图
    lazy var customizeContainer: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), collectionViewLayout: self.rowStyleFlowLayout)
        collectionView.register(RowStyleCardViewCell.self, forCellWithReuseIdentifier: JJRowStyleCardID)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.bounces = false
        return collectionView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.customizeContainer.delegate = nil
        self.customizeContainer.dataSource = nil
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        self.addSubview(self.customizeContainer)
        
        // 设置 customizeContainer 大小约束
        self.customizeContainer.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}

extension RowStyleCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension RowStyleCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJRowStyleCardID, for: indexPath) as! RowStyleCardViewCell
//        let result:HotListResult = self.hotList![indexPath.row]
//        cell.updateUI(coverUrl: result.picURL, desc: result.name, views: String(result.playCount))
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension RowStyleCollectionView {
    
    
    
}
