//
//  CardCollectionView.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/26.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SnapKit

let RecomendAlbumId = "RecomendAlbumId"

/// 通用的卡片滚动视图，该控件适用于横向滚动并且上图下文形式
class CardCollectionView: UIView {
    
    let margin: CGFloat = 10
    
    // 推荐歌单数据
    private var songList: [Creative]? {
        didSet{
            if songList != nil {
                self.hotAlbumContainer.reloadData()
            }
        }
    }
        
    /// 布局
    lazy var cardFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: -20, left: margin, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    
    /// 歌单的视图
    lazy var hotAlbumContainer: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.cardFlowLayout)
        collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: RecomendAlbumId)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.bounces = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.hotAlbumContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.hotAlbumContainer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        // 设置 item size 大小
        self.cardFlowLayout.itemSize = CGSize(width: itemA_width * scaleW, height: self.frame.size.height - 3 * margin)
        
    }
    
    deinit {
        self.hotAlbumContainer.delegate = nil
        self.hotAlbumContainer.dataSource = nil
    }
}

// MARK: - UICollectionViewDelegate
extension CardCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension CardCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.songList == nil {
            return 0
        }
        return self.songList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendAlbumId, for: indexPath) as! CardViewCell
        let result:Creative = self.songList![indexPath.row]
        if result.creativeType == "voiceList" {
            cell.updateUI(coverUrl: (result.uiElement?.image!.imageURL)!, desc: (result.uiElement?.mainTitle!.title)!, views: String((result.creativeEXTInfoVO?.playCount)!))
        } else {
            let element = result.resources?[0]
            cell.updateUI(coverUrl: (element?.uiElement.image.imageURL)!, desc: (element?.uiElement.mainTitle.title)!, views: String((element?.resourceEXTInfo?.playCount)!))
        }
        
        return cell
    }
}

// MARK: - 初始化
extension CardCollectionView {
    // 更新 UI
    open func updateUI(songList: [Creative]?){
        self.songList = songList
    }
}
