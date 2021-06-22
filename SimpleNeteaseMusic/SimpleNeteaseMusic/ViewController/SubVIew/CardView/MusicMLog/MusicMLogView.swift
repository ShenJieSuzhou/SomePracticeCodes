//
//  MusicMLogView.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/6/3.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

let JJMusicMLogCellId = "JJMusicMLogCellId"

/// 音乐VLog
class MusicMLogView: UIView {
    
    let margin: CGFloat = 10
    
    // 推荐视频数据
    private var musicMLogList: [EXTInfoElement]? {
        didSet{
            if musicMLogList != nil {
                self.musicMLogContainer.reloadData()
            }
        }
    }
        
    /// 布局
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: -20, left: margin, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    
    lazy var musicMLogContainer: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), collectionViewLayout: self.flowLayout)
        collectionView.register(MusicMLogViewCell.self, forCellWithReuseIdentifier: JJMusicMLogCellId)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.musicMLogContainer)
        
        // 设置 item size 大小
        self.flowLayout.itemSize = CGSize(width: 100 * scaleW, height: self.frame.size.height - margin * 3)
        
        self.musicMLogContainer.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    deinit {
        self.musicMLogContainer.delegate = nil
        self.musicMLogContainer.dataSource = nil
    }
}

// MARK: - UICollectionViewDelegate
extension MusicMLogView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension MusicMLogView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.musicMLogList == nil {
            return 0
        }
        
        return self.musicMLogList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJMusicMLogCellId, for: indexPath) as! MusicMLogViewCell
        let result:EXTInfoElement = self.musicMLogList![indexPath.row]
        cell.updateUI(coverUrl: result.resource.mlogBaseData.coverURL, desc: result.resource.mlogBaseData.text, views: String(result.resource.mlogEXTVO.playCount))
        return cell
    }
}

// MARK: - 初始化
extension MusicMLogView {
    // 更新 UI
    open func updateUI(songList: [EXTInfoElement]?){
        self.musicMLogList = songList
    }
}
