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

/// 首页圆形按钮
class HomeMenu: UIView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let margin: CGFloat = 10
    
    // 分割线
    lazy var separtor: UIImageView = {
        let line = UIImageView(frame: CGRect.zero)
        line.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        return line
    }()
    
    // 圆形图标布局
    private lazy var menusViewFlowLayout: UICollectionViewFlowLayout = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.minimumLineSpacing = 0
        collectionFlowLayout.minimumInteritemSpacing = 0
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
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
        collectionView.bounces = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.bounces = false
        return collectionView
    }()
    
    // 数据源
    private var menusArray: [Datum]! {
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
        
        self.menusContainer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        self.menusViewFlowLayout.itemSize = CGSize(width: 75 * scaleW, height: self.bounds.size.height-20)
        self.menusViewFlowLayout.scrollDirection = .horizontal
        self.separtor.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.1)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.menusContainer)
        self.addSubview(self.separtor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.menusContainer.delegate = nil
        self.menusContainer.dataSource = nil
    }
}

extension HomeMenu {
    public func updateUI(data: [Datum]?){
        self.menusArray = data
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeMenu {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menusArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.menusArray != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJDragonBallCellId, for: indexPath) as! HomeMenuCell
            let model:Datum = self.menusArray[indexPath.row]
            cell.setupUI(imageUrl: model.iconURL, title: model.name)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJDragonBallCellId, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
}


