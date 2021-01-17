//
//  RowStyleLayout.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/1/15.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class RowStyleLayout: UICollectionViewFlowLayout {
    
    private var lastOffset: CGPoint!
    
    override init() {
        super.init()
        lastOffset = CGPoint.zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化
    override func prepare() {
        
        super.prepare()
        self.collectionView?.decelerationRate = .fast
    }
    
    // 这个方法的返回值，决定了 CollectionView 停止滚动时的偏移量
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        // 分页的 width
        let pageSpace = self.stepSpace()
        let offsetMax: CGFloat = self.collectionView!.contentSize.width - (pageSpace + self.sectionInset.right + self.minimumLineSpacing)
        let offsetMin: CGFloat = 0
        
        // 修改之前记录的位置，如果小于最小的contentsize或者最大的contentsize则重置值
        if lastOffset.x < offsetMin {
            lastOffset.x = offsetMin
        } else if lastOffset.x > offsetMax{
            lastOffset.x = offsetMax
        }
        
        // 目标位移点距离当前点距离的绝对值
        let offsetForCurrentPointX: CGFloat = abs(proposedContentOffset.x - lastOffset.x)
        let velocityX = velocity.x
        
        // 判断当前滑动方向，向左 true, 向右 fasle
        let direction: Bool = (proposedContentOffset.x - lastOffset.x) > 0
        
        var newProposedContentOffset: CGPoint = CGPoint.zero
        
        if (offsetForCurrentPointX > pageSpace/8.0) && (lastOffset.x >= offsetMin) && (lastOffset.x <= offsetMax) {
            // 分页因子，用于计算滑过的cell数量
            var pageFactor: NSInteger = 0
            if velocityX != 0 {
                // 滑动
                // 速率越快，cell 滑过的数量越多
                pageFactor = abs(NSInteger(velocityX))
            } else {
                // 拖动
                pageFactor = abs(NSInteger(offsetForCurrentPointX / pageSpace))
            }
            
            //设置 pageFactor 的上限为2，防止滑动速率过大，导致翻页过多
            pageFactor = pageFactor < 1 ? 1: (pageFactor < 3 ? 1: 2)
            
            let pageOffsetX: CGFloat = pageSpace * CGFloat(pageFactor)
            newProposedContentOffset = CGPoint(x: lastOffset.x + (direction ? pageOffsetX : -pageOffsetX), y: proposedContentOffset.y)
        } else {
            // 滚动距离小于翻页步距，则不进行翻页
            newProposedContentOffset = CGPoint(x: lastOffset.x, y: lastOffset.y)
        }
        
        lastOffset.x = newProposedContentOffset.x
        return newProposedContentOffset
    }
    
    // 每滑动一页的间距
    public func stepSpace() -> CGFloat {
        return self.itemSize.width + self.minimumLineSpacing
    }
}
