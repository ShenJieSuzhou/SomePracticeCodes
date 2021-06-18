//
//  MusicCalendarView.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/6/4.
//  Copyright © 2021 shenjie. All rights reserved.
//

import UIKit
import SnapKit

let JJMusicCalendarCellId = "JJMusicCalendarCellId"

class MusicCalendarView: UIView {
    
    let margin: CGFloat = 10
    
    // 推荐歌单数据
    private var calendar: [Creative]? {
        didSet{
            if calendar != nil {
                self.calendarContainer.reloadData()
            }
        }
    }
        
    /// 布局
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: -20, left: margin, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    
    /// 日历视图容器
    lazy var calendarContainer: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), collectionViewLayout: self.flowLayout)
        collectionView.register(MusicCalendarViewCell.self, forCellWithReuseIdentifier: JJMusicCalendarCellId)
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
        self.addSubview(self.calendarContainer)
        
        // 设置 item size 大小
        self.flowLayout.itemSize = CGSize(width: self.frame.size.width, height: self.frame.size.height - 3 * margin)
        
        self.calendarContainer.frame = self.bounds
    }
    
    deinit {
        self.calendarContainer.delegate = nil
        self.calendarContainer.dataSource = nil
    }
}

// MARK: - UICollectionViewDelegate
extension MusicCalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension MusicCalendarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.calendar == nil {
            return 0
        }
        
        return self.calendar!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJMusicCalendarCellId, for: indexPath) as! MusicCalendarViewCell
        let result:Creative = self.calendar![indexPath.row]
        let element = result.resources?[0]
        if element?.uiElement.labelTexts != nil {
            let tag: String = (element?.uiElement.labelTexts?[0])!
            cell.updateUI(tag: tag, title: (element?.uiElement.mainTitle.title)!, coverUrl: (element?.uiElement.image.imageURL)!)
        } else {
            cell.updateUI(tag: "", title: (element?.uiElement.mainTitle.title)!, coverUrl: (element?.uiElement.image.imageURL)!)
        }
        
        return cell
    }
}

// MARK: - 初始化
extension MusicCalendarView {
    // 更新 UI
    open func updateUI(data: [Creative]?){
        self.calendar = data
    }
}
