//
//  VoiceListView.swift
//  SimpleNeteaseMusic
//
//  Created by snaigame on 2021/6/6.
//  Copyright © 2021 shenjie. All rights reserved.
//

import UIKit
import SnapKit

let PodcastViewCellId = "PodcastViewCellId"

class PodcastView: UIView {

    let margin: CGFloat = 10
    
    // 推荐歌单数据
    private var voiceList: [Creative]? {
        didSet{
            if voiceList != nil {
                self.voiceContainer.reloadData()
            }
        }
    }
        
    /// 布局
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: -20, left: margin, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    
    /// 歌单的视图
    lazy var voiceContainer: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), collectionViewLayout: self.flowLayout)
        collectionView.register(PodcastViewCell.self, forCellWithReuseIdentifier: PodcastViewCellId)
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
        self.addSubview(self.voiceContainer)
        
        // 设置 item size 大小
        self.flowLayout.itemSize = CGSize(width: 120, height: self.frame.size.height - 3 * margin)
        
        self.voiceContainer.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    deinit {
        self.voiceContainer.delegate = nil
        self.voiceContainer.dataSource = nil
    }
}

// MARK: - UICollectionViewDelegate
extension PodcastView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension PodcastView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.voiceList == nil {
            return 0
        }
        
        return self.voiceList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PodcastViewCellId, for: indexPath) as! PodcastViewCell
        let result:Creative = self.voiceList![indexPath.row]
        cell.updateUI(coverUrl: (result.uiElement?.image!.imageURL)!, desc: (result.uiElement?.mainTitle!.title)!)
        
        return cell
    }

}

// MARK: - 初始化
extension PodcastView {
    // 更新 UI
    open func updateUI(voiceList: [Creative]?){
        self.voiceList = voiceList
    }
}
