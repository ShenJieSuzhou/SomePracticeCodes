//
//  HomeMenu.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/18.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

let JJDragonBallCellId = "JJDragonBallCellId"

// 点击cell回调
public typealias MenuDidClickedBlock = (_ currentIndex: Int) -> Void

class HomeMenu: UIView , UICollectionViewDelegate, UICollectionViewDataSource{
    // 圆形图标布局
    private lazy var menusViewFlowLayout: UICollectionViewFlowLayout = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.minimumLineSpacing = 0
        collectionFlowLayout.minimumInteritemSpacing = 0
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionFlowLayout.itemSize = CGSize(width: 60, height: 60)
        return collectionFlowLayout
    }()
    
    // 圆形图标入口
    private lazy var menusContainer: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), collectionViewLayout: self.menusViewFlowLayout)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.bounces = false
        self.addSubview(collectionView)
        return collectionView
    }()
    
    // 数据源
    private var menusArray: [DragonBallModel]! {
        didSet{
            if menusArray != nil {
                self.menusContainer.register(HomeMenuCell.self, forCellWithReuseIdentifier: JJDragonBallCellId)
            }
            self.menusContainer.reloadData()
            self.layoutIfNeeded()
        }
    }
    
    // 资源数量
    private var sourceCount: Int!{
        if self.menusArray != nil {
            return self.menusArray.count
        }
        return 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.menusContainer.frame = self.bounds
        self.menusViewFlowLayout.scrollDirection = .horizontal
    }
    
    deinit {
        self.menusContainer.delegate = nil
        self.menusContainer.dataSource = nil
    }
}

extension HomeMenu {
    
    public func update(data: [DragonBallModel]?){
        self.menusArray = data
    }
//   // 初始化
//    @objc open class func create(frame: CGRect, imageUrlStrArray: [AnyObject]?, placeholderImage:UIImage?) -> JJNewsBanner{
//        let newsBanner = JJNewsBanner(frame: frame)
//        newsBanner.updateUI(localImageArray: nil, imageUrlStrArray: imageUrlStrArray, placeholderImage: placeholderImage, viewArray: nil)
//
//        return newsBanner
//    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeMenu {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menusArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.menusArray != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJDragonBallCellId, for: indexPath) as! HomeMenuCell
            let model:DragonBallModel = self.menusArray[indexPath.row]
            cell.setupUI(imageName: model.menuIcon!, title: model.menuTitle!)
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJImageViewCellId, for: indexPath)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
}


