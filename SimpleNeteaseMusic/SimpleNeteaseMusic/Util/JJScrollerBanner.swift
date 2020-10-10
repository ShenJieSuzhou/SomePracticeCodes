//
//  JJScrollerBanner.swift
//  SimpleNeteaseMusic
//
//  Created by snaigame on 2020/10/3.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import Kingfisher

class JJScrollerBanner: UIView, UIScrollViewDelegate {
    
    enum ImageType{
        case Image  // 本地图片
        case URL    // URL
    }
    
    private var scrollView: UIScrollView = UIScrollView()
    
    // PageController
    private var pageController: UIPageControl = UIPageControl()
    
    private var centerImage:UIImageView = UIImageView()
    
    private var firstImage:UIImageView = UIImageView()
    
    private var secondImage:UIImageView = UIImageView()
    
    // 数据源
    private var bannersData:Array<String> = []
    private var type:ImageType = .Image
    
    private var width:CGFloat = 0
    private var height:CGFloat = 0
    
    private var currIndex = 0
    private var timer:Timer?
    
    // 默认自动播放
    var isAuto = true
    var interval:Double = 4
    
    // default color
    open var pageControlTintColor: UIColor = UIColor.lightGray

    // active color
    open var pageControlCurrentPageColor: UIColor = UIColor.white
    
//    // 容器组件
//    fileprivate var collectionView: UICollectionView!
//
//    // Identifier
//    fileprivate let identifier = "JJScrollerBannerCell"
//
//    // UICollectionViewFlowlayout
//    lazy fileprivate var flowLayout: UICollectionViewFlowLayout? = {
//        let tempFlowLayout = UICollectionViewFlowLayout.init()
//        tempFlowLayout.minimumLineSpacing = 0
//        tempFlowLayout.scrollDirection = .horizontal
//        return tempFlowLayout
//    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func setImages(images:Array<String>, type:ImageType = .Image){
        self.type = type
        self.bannersData = images
        self.initLayout()
    }
    
    
    private func initLayout(){
        if (self.bannersData.count == 0){
            return
        }
        
        width = frame.size.width
        height = frame.size.width
        // 初始化 scrollView
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(width: width * CGFloat(3), height: height)
        scrollView.contentOffset = CGPoint(x: width, y: 0)
        scrollView.isUserInteractionEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        addSubview(scrollView)
        
        // 左边图
        firstImage.frame = CGRect(x: 0, y: 0, width: width, height: height)
        firstImage.contentMode = .scaleAspectFill
        firstImage.isUserInteractionEnabled = true
        scrollView.addSubview(firstImage)
        
        // 中间图
        centerImage.frame = CGRect(x: width, y: 0, width: width, height: height)
        centerImage.contentMode = .scaleAspectFill
        centerImage.isUserInteractionEnabled = true
        scrollView.addSubview(centerImage)
        
        // 右边图
        secondImage.frame = CGRect(x: width * 2.0, y: 0, width: width, height: height)
        secondImage.contentMode = .scaleAspectFill
        secondImage.isUserInteractionEnabled = true
        scrollView.addSubview(secondImage)
        
        pageController.center = CGPoint(x: width/2, y: height - CGFloat(20))
        pageController.isEnabled = true
        pageController.numberOfPages = bannersData.count
        pageController.currentPageIndicatorTintColor = pageControlTintColor
        pageController.isUserInteractionEnabled = false
        addSubview(pageController)
        
        if(isAuto){
            
        }
        
        setCurrent(currIndex: 0)
    }
    
    func setCurrent(currIndex: Int) {
        self.currIndex = currIndex
        
        if(type == .Image){
            centerImage.image = UIImage.init(named: bannersData[currIndex])
            firstImage.image = UIImage.init(named: bannersData[(currIndex - 1 + bannersData.count) % bannersData.count])
            secondImage.image = UIImage.init(named: bannersData[(currIndex + 1) % bannersData.count])
        }else{
            centerImage.setMyImage(URL: NSURL(string: bannersData[currIndex]))
            firstImage.setMyImage(URL:  NSURL(string: bannersData[(currIndex - 1 + bannersData.count) % bannersData.count]))
            secondImage.setMyImage(URL: NSURL(string: bannersData[(currIndex + 1) % bannersData.count]))
        }
        centerImage.tag = currIndex
        pageController.currentPage = currIndex
        scrollView.setContentOffset(CGPoint(x: width, y: 0), animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        openTimer()
    }
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x > 0){
            currIndex = (currIndex + 1) % bannersData.count
        }else {
            currIndex = (currIndex - 1 + bannersData.count) % bannersData.count
        }
        setCurrent(currIndex: currIndex)
    }
    
    func openTimer(){
        if(isAuto){
            if(timer == nil){
                timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(startAutoScroll), userInfo: nil, repeats: true)
            }
        }
    }
    
    func closeTimer(){
        if(timer != nil){
            timer?.invalidate()
            timer = nil
        }
    }


    @objc func startAutoScroll(){
        if(isDisplayInScreen()){
            setCurrent(currIndex: (currIndex + 1) % bannersData.count)
        }
    }

    func isDisplayInScreen() -> Bool {
        if(self.window == nil){
            return false
        }
        return true
    }
    
}



extension UIImageView{
    public func setMyImage(URL: NSURL?, placeholderImage: Image? = nil, optionsInfo: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: CompletionHandler? = nil){
        
        kf.setImage(with: URL as? Resource, placeholder: placeholderImage, options: optionsInfo, progressBlock: progressBlock, completionHandler: completionHandler)
    }
}