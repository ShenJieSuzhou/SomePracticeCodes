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
    private var bannersData:Array<BannerModel> = []
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
        
        // 设置圆角
        let maskPath = UIBezierPath.init(roundedRect: self.bounds,
                                         byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft, UIRectCorner.bottomRight],
                cornerRadii: CGSize(width: 10, height: 10))

        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    public func setBannerImages(images:Array<BannerModel>, type:ImageType = .URL){
        self.type = type
        self.bannersData = images
        self.initLayout()
    }
    
    
    private func initLayout(){
        if (self.bannersData.count == 0){
            return
        }
        
        width = frame.size.width
        height = frame.size.height
        // 初始化 scrollView
        scrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scrollView.contentSize = CGSize(width: width * CGFloat(3), height: height)
        scrollView.contentOffset = CGPoint(x: width, y: 0)
        scrollView.isUserInteractionEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.clear
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
        
        pageController.center = CGPoint(x: width/2, y: height - CGFloat(50))
        pageController.isEnabled = true
        pageController.numberOfPages = bannersData.count
        pageController.currentPageIndicatorTintColor = pageControlTintColor
        pageController.isUserInteractionEnabled = false
        scrollView.addSubview(pageController)
        
        if(isAuto){
            
        }
        
        setCurrent(currIndex: 0)
    }
    
    func setCurrent(currIndex: Int) {
        self.currIndex = currIndex
        
        if(type == .Image){
            centerImage.image = UIImage.init(named: bannersData[currIndex].pic!)
            firstImage.image = UIImage.init(named: bannersData[(currIndex - 1 + bannersData.count) % bannersData.count].pic!)
            secondImage.image = UIImage.init(named: bannersData[(currIndex + 1) % bannersData.count].pic!)
        }else{
//            centerImage.setMyImage(URL: NSURL(string: bannersData[currIndex].pic!) )
//            firstImage.setMyImage(URL:  NSURL(string: bannersData[(currIndex - 1 + bannersData.count) % bannersData.count].pic!))
//            secondImage.setMyImage(URL: NSURL(string: bannersData[(currIndex + 1) % bannersData.count].pic!))
                        
            centerImage.kf.setImage(with: URL(string: bannersData[currIndex].pic!))
            firstImage.kf.setImage(with: URL(string: bannersData[(currIndex - 1 + bannersData.count) % bannersData.count].pic!))
            secondImage.kf.setImage(with: URL(string: bannersData[(currIndex + 1) % bannersData.count].pic!))
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
    public func setMyImage(URL: NSURL?, placeholderImage: UIImage? = nil, optionsInfo: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: CompletionHandler? = nil){
        
//        kf.setImage(with: URL as? Resource, placeholder: placeholderImage, options: optionsInfo, progressBlock: progressBlock, completionHandler: completionHandler)
        kf.setImage(with: URL as? Resource,
                    placeholder: placeholderImage,
                    options: optionsInfo,
                    progressBlock: progressBlock)
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
    }
}
