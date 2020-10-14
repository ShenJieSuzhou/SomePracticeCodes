//
//  JJNewsBanner.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/10/14.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit


let JJImageViewCellId = "JJImageViewCellId"


@objc public enum PageControlType: Int{
    case none
    case classic
    case custom
}

@objc public enum JJCustomDotType: Int{
    case hollow
    case solid
    case image
}

@objc public enum PageControlAligment: Int{
    case center
    case right
    case left
}

// 点击cell回调
public typealias ItemDidClickedBlock = (_ currentIndex: Int) -> Void


class JJNewsBanner: UIView{
        
    // 布局
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        return collectionViewFlowLayout
    }()
    
    // collection
    private lazy var collectionView: UICollectionView = {
    
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), collectionViewLayout: self.collectionViewFlowLayout)
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
    
    
    // 占位图
    public var placeholderImage: UIImage?
    
    // 网络图片URL
    @objc public var imageUrlStrArray: [String]?{
        didSet{
            if imageUrlStrArray != nil {
                self.collectionView.register(JJNewsImageViewCell.self, forCellWithReuseIdentifier: JJImageViewCellId)
                
                self.sourceArray = imageUrlStrArray as [AnyObject]?
            }
        }
    }
    
    // 传入的资源
    private var sourceArray: [AnyObject]? {
        didSet{
            if sourceArray != nil && sourceArray!.count > 0 {
                let currentIndex = self.currentIndex()
                if currentIndex != 0 {
                    var row = 0
                    if currentIndex > sourceArray!.count {
                        row = currentIndex - currentIndex % sourceArray!.count
                    }
                    self.collectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: UICollectionView.ScrollPosition.left, animated: false)
                }
                self.collectionView.reloadData()
                self.setupPageControl()
                self.invalidateTimer()
                
                if autoScroll {
                    self.setupTimer()
                }
                self.layoutIfNeeded()
            }
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
    @objc public var autoScroll = true
    
    // 轮播时间间隔
    @objc public var autoScrollTimeInterval: TimeInterval = 5.0
    
    // 分页控件
    private var pageControl: UIControl?
    
    // 轮播次数
    private var loopTimes = 100
    
    // item 总数
    private var totalItemCount: Int!
    
    /// 分页控件位置
    public var pageControlAliment: PageControlAligment = .center
    
    /// 分页控件类型
    public var pageControlType: PageControlType = .classic
   
    // 当前分页控件颜色
    public var currentPageDotColor = UIColor.white
    
    // 默认分页控件颜色
    public var pageDotColor = UIColor.lightGray
    
    /// 分页控件默认距离的边距
    public var pageControlMargin: CGFloat = 10
    
    /// 分页控件大小，注意：当PageControlType不等于自定义类型时，只能影响当前分页控件的大小，不能影响分页控件原点的大小
    public var pageControlDotSize: CGSize = CGSize(width: 10, height: 10) {
        didSet {
            self.setupPageControl()
        }
    }
    
    /// 某一项点击回调
    @objc public var itemDidClickedBlock: ItemDidClickedBlock?
    
    /// 图片ContentMode
    private var myContentMode: UIView.ContentMode = .scaleToFill
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.bounds
        self.collectionViewFlowLayout.itemSize = self.frame.size
        self.collectionViewFlowLayout.scrollDirection = .horizontal
        
        if self.collectionView.contentOffset.x == 0 && self.totalItemCount > 0 {
            self.startScrollToItem(targetIndex: 0, animated: true)
        }
    
        if self.pageControl != nil {
            var pSize = CGSize(width: 0, height: 0)
            if self.pageControl!.isKind(of: UIPageControl.self) {
                pSize = CGSize(width: CGFloat(self.sourceCount) * self.pageControlDotSize.width, height: self.pageControlDotSize.height)
            } else {
                
            }
            
            var pX: CGFloat = 0
            if self.pageControlAliment == .center {
                pX = (self.frame.width - pSize.width) / 2
            } else if self.pageControlAliment == .left {
                pX = pageControlMargin + 10
            } else if self.pageControlAliment == .right {
                pX = self.frame.width - pSize.width - (pageControlMargin + 10)
            }
            let pY = self.frame.height - pSize.height - pageControlMargin
            
            let pageControlFrame = CGRect(x: pX, y: pY, width: pSize.width, height: pSize.height)
            self.pageControl!.frame = pageControlFrame
        }
    }
    
    private func currentIndex() -> Int {
        if collectionView.frame.width == 0 || collectionView.frame.height == 0 {
            return 0
        }
        
        var index = 0
        if self.collectionViewFlowLayout.scrollDirection == .horizontal {
            index = Int((self.collectionView.contentOffset.x + self.collectionViewFlowLayout.itemSize.width * 0.5) /
                            self.collectionViewFlowLayout.itemSize.width)
        }else{
            
        }
        
        return max(0, index)
    }
    
    private func setupPageControl() {
        if self.sourceArray == nil {
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
            tmpPageControl.currentPage = self.currentIndex()
            self.addSubview(tmpPageControl)
            
            self.pageControl = tmpPageControl
        case .custom:
            self.pageControl = nil
        }
    }
    
    deinit {
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
    }
}

// MARK: - 初始化
extension JJNewsBanner {
    
    // 初始化
    @objc open class func startPlay(frame: CGRect, imageUrlStrArray: [String]?, placeholderImage:UIImage?) -> JJNewsBanner{
        let newsBanner = JJNewsBanner(frame: frame)
        newsBanner.updateUI(localImageArray: nil, imageUrlStrArray: imageUrlStrArray, placeholderImage: placeholderImage, viewArray: nil)
        
        return newsBanner
    }
    
    // 更新 UI
    private func updateUI(localImageArray: [String]?, imageUrlStrArray: [String]?, placeholderImage: UIImage?, viewArray: [UIView]?){
        self.imageUrlStrArray = imageUrlStrArray
        self.placeholderImage = placeholderImage
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension JJNewsBanner: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.totalItemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.imageUrlStrArray != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJImageViewCellId, for: indexPath) as! JJNewsImageViewCell
            cell.setupUI(imageName: nil, imageUrl: (self.imageUrlStrArray != nil ? self.imageUrlStrArray![indexPath.row] : nil), placeholderImage: self.placeholderImage, contentMode: self.myContentMode)
            cell.backgroundColor = UIColor.white
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JJImageViewCellId, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if self.itemDidClickedBlock != nil {
            self.itemDidClickedBlock!(indexPath.row % self.sourceCount)
        }
    }
}

// MARK: - Scroll logic
extension JJNewsBanner{
 
    public func setupTimer() {
        self.invalidateTimer()
        
        if self.autoScroll {
            self.scrollTimer = Timer.scheduledTimer(timeInterval: self.autoScrollTimeInterval, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
            RunLoop.main.add(self.scrollTimer!, forMode: .common)
        }
    }
    
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
    
    
    // 手动控制滚动
    public func makeScrollViewScrollToIndex(index: Int){
        self.invalidateTimer()
        
        
    }

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
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.sourceCount == 0 || self.pageControl == nil {
            return
        }
        
        let itemIndex = self.currentIndex()
        //let indexOnPageControl = self.pageControlIndex(cellIndex: itemIndex)
        
        if self.pageControl!.isKind(of: UIPageControl.self) {
            (self.pageControl as! UIPageControl).currentPage = itemIndex
        }
//        else {
//            (self.pageControl as! FWPageControl).currentPage = indexOnPageControl
//        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.invalidateTimer()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.setupTimer()
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(self.collectionView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if self.sourceCount == 0 {
            return
        }
        
        let itemIndex = self.currentIndex()
        if self.itemDidClickedBlock != nil {
            self.itemDidClickedBlock!(itemIndex)
        }
    }
}
