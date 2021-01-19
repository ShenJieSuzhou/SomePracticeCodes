//
//  JJNewsBanner.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/10/14.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit


let JJScrollBannerCellID = "JJScrollBannerCellID"

public enum PageControlType: Int{
    case none
    case classic
    case custom
}

public enum PageControlAligment: Int{
    case center
    case right
    case left
}

// 点击 cell 回调
public typealias ItemDidClickedBlock = (_ currentIndex: Int) -> Void


class JJNewsBanner: UIView {
    
    // item 左右边距
    private let margin: CGFloat = 20
        
    // 布局
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    // collection
    private var collectionView: UICollectionView!
    
    // 占位图
    public var placeholderImage: UIImage?
    
    // 网络图片URL
    public var imageUrlStrArray: [BannerModel]?{
        didSet{
            self.collectionView.reloadData()
            self.setupPageControl()
            self.invalidateTimer()

            if autoScroll {
                self.setupTimer()
            }
            
            self.layoutIfNeeded()
        }
    }
    
    
    // 资源总数
    private var sourceCount: Int{
        if self.imageUrlStrArray != nil {
            return self.imageUrlStrArray!.count
        }
        
        return 0
    }
    
    // 定时器
    private var scrollTimer: Timer?
    
    // 是否自动轮播
    public var autoScroll = true {
        didSet {
            self.invalidateTimer()
            if autoScroll {
                self.setupTimer()
            }
        }
    }
    
    // 轮播时间间隔
    public var autoScrollTimeInterval: TimeInterval = 2.0 {
        didSet {
            self.invalidateTimer()
            if autoScrollTimeInterval > 0 {
                self.setupTimer()
            }
        }
    }
    
    // 分页控件
    private var pageControl: UIPageControl?
    
    // 轮播次数
    private var loopTimes = 100
    
    // item 总数
    private var totalItemCount: Int {
        return self.sourceCount
    }
    
    // 分页控件位置
    public var pageControlAliment: PageControlAligment = .center
    
    // 分页控件类型
    public var pageControlType: PageControlType = .classic
   
    // 当前分页控件颜色
    public var currentPageDotColor = UIColor.white
    
    // 默认分页控件颜色
    public var pageDotColor = UIColor.gray
    
    // 分页控件默认距离的边距
    public var pageControlMargin: CGFloat = 10
    
    // 分页控件大小，注意：当PageControlType不等于自定义类型时，只能影响当前分页控件的大小，不能影响分页控件原点的大小
    public var pageControlDotSize: CGSize = CGSize(width: 10, height: 10)
    
    // 某一项点击回调
    @objc public var itemDidClickedBlock: ItemDidClickedBlock?
    
    // 图片ContentMode
    private var myContentMode: UIImageView.ContentMode = .scaleAspectFill
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
    }
}


// MARK: - lifeCycle
extension JJNewsBanner {
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if self.collectionView.contentOffset.x == 0 && self.totalItemCount > 0 {
            var targetIndex = 0
            if self.loopTimes > 0 {
                targetIndex = 0
            }
            if self.collectionView.numberOfItems(inSection: 0) == self.totalItemCount && self.loopTimes > 1 {
                self.startScrollToItem(targetIndex: targetIndex, animated: false)
            }
        }

        if self.pageControl != nil {
            var pSize: CGSize = CGSize(width: 0, height: 0)
            if self.pageControl!.isKind(of: UIPageControl.self) {
                pSize = CGSize(width: CGFloat(self.sourceCount) * self.pageControlDotSize.width, height: self.pageControlDotSize.height)
            }

            let pX: CGFloat = 0
            let pY = self.frame.height - margin - pSize.height - pageControlMargin

            let pageControlFrame = CGRect(x: pX, y: pY, width: self.frame.width, height: pSize.height)
            self.pageControl!.frame = pageControlFrame

            if #available(iOS 14.0, *) {
                self.pageControl?.backgroundStyle = .automatic
            }
        }
    }
    
    // 设置滚动分页控件
    private func setupPageControl() {
        if self.imageUrlStrArray == nil {
            return
        }
        if self.pageControl != nil {
            self.pageControl?.removeFromSuperview()
        }
        
        switch self.pageControlType {
        case .none:
            self.pageControl = nil
        case .classic:
            let tmpPageControl = UIPageControl()
            tmpPageControl.numberOfPages = self.sourceCount
            tmpPageControl.currentPageIndicatorTintColor = self.currentPageDotColor
            tmpPageControl.pageIndicatorTintColor = self.pageDotColor
            tmpPageControl.isUserInteractionEnabled = false
            tmpPageControl.currentPage = self.pageControlIndex(cellIndex: self.currentIndex())
            self.addSubview(tmpPageControl)
            self.pageControl = tmpPageControl
        case .custom:
            self.pageControl = nil
        }
    }
    
    // 页转换
    private func pageControlIndex(cellIndex: Int) -> Int {
        if self.sourceCount > 0 {
            return cellIndex % self.sourceCount
        } else {
            return 0
        }
    }
    
    // 当前页面索引
    private func currentIndex() -> Int {
        if collectionView.frame.width == 0 || collectionView.frame.height == 0 {
            return 0
        }
        
        var index = 0
        index = Int((self.collectionView.contentOffset.x + self.collectionViewFlowLayout.itemSize.width * 0.5) / self.collectionViewFlowLayout.itemSize.width)

        return max(0, index)
    }
}



// MARK: - Configuration UI
extension JJNewsBanner {
    
    // 构建 UI
    private func configUI() {
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.itemSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(JJNewsImageViewCell.self, forCellWithReuseIdentifier: JJScrollBannerCellID)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        self.addSubview(collectionView)
    }
    
    // 更新 UI
    public func updateUI(imageUrlStrArray: [AnyObject]?, placeholderImage: UIImage?){
        
        self.imageUrlStrArray = imageUrlStrArray as? [BannerModel]
        self.placeholderImage = placeholderImage
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension JJNewsBanner :UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.totalItemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.imageUrlStrArray != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJScrollBannerCellID, for: indexPath) as! JJNewsImageViewCell
            cell.setupUI(imageName: nil, imageUrl: (self.imageUrlStrArray != nil ? self.imageUrlStrArray![indexPath.row].pic : nil), placeholderImage: self.placeholderImage, contentMode: self.myContentMode)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJScrollBannerCellID, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if self.itemDidClickedBlock != nil {
            self.itemDidClickedBlock!(indexPath.row % self.sourceCount)
        }
    }
}

// MARK: - Scroll Logic
extension JJNewsBanner{
    
    // 设置定时器
    public func setupTimer() {
        self.invalidateTimer()

        if self.autoScroll {
            self.scrollTimer = Timer.scheduledTimer(timeInterval: self.autoScrollTimeInterval, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
            RunLoop.main.add(self.scrollTimer!, forMode: .common)
        }
    }

    // 使定时器失效
    public func invalidateTimer() {
        if self.scrollTimer != nil {
            self.scrollTimer?.invalidate()
            self.scrollTimer = nil
        }
    }

    @objc private func automaticScroll(){
        if self.totalItemCount == 0 {
            return
        }

        var targetIndex = self.currentIndex() + 1
        self.scrollToIndex(targetIndex: &targetIndex)
    }

    override func willMove(toSuperview newSuperview: UIView?) {

        if newSuperview == nil {
            self.invalidateTimer()
        }
    }

    // 滚动到指定索引
    public func scrollToIndex(targetIndex: inout Int){
        if self.collectionView.numberOfItems(inSection: 0) != self.totalItemCount {
            return
        }

        if targetIndex >= self.totalItemCount {
            if self.loopTimes == 1 {
                self.startScrollToItem(targetIndex: 0, animated: true)
            } else if self.loopTimes > 1 {
                targetIndex = self.totalItemCount / 2
                self.startScrollToItem(targetIndex: targetIndex, animated: false)
            }
            return
        }
        
        self.startScrollToItem(targetIndex: targetIndex, animated: true)
    }

    private func startScrollToItem(targetIndex: Int, animated: Bool){
        self.collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: .right, animated: animated)
    }

    // 设置页面控制器当前页索引
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.sourceCount == 0 || self.pageControl == nil {
            return
        }

        let itemIndex = self.currentIndex()
        let indexOnPageControl = self.pageControlIndex(cellIndex: itemIndex)

        if self.pageControl!.isKind(of: UIPageControl.self) {
            self.pageControl?.currentPage = indexOnPageControl
        }
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.invalidateTimer()
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.setupTimer()
    }
}
