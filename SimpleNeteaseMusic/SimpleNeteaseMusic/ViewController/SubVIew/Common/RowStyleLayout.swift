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
    
    // 初始化
    override func prepare() {
        
        super.prepare()
    }
    
    // cell 怎么排布
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 屏幕上显示的 cell
        let array = super.layoutAttributesForElements(in: rect) ?? []

        var attributesCopy = [UICollectionViewLayoutAttributes]()
        for itemAttributes in array {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            attributesCopy.append(itemAttributesCopy)
        }
        
//        for attrs in attributesCopy {
//            attrs.size = CGSize(width: attrs.size.width - 40, height: attrs.size.height)
//                // 计算 cell 中点的 x 值 与 centerX 的差值
//                let delta = abs(centerX - attrs.center.x)
//                // W：[0.8 ~ 1.0]
//                // H：[0.3 ~ 1.0]
//                // 反比
//                let baseScale = 1 - delta / (collectionView!.frame.size.width + itemSize.width)
//                let scaleW = minScaleW + baseScale * (1 - minScaleW)
//                let scaleH = minScaleH + baseScale * (1 - minScaleH)
//                let alpha = minAlpha + baseScale * (1 - minAlpha)
//                // 改变transform（越到中间 越大）
//                attrs.transform =CGAffineTransformMakeScale(scaleW, scaleH)
//                if setAlpha {
//                    // 改变透明度（越到中间 越不透明）
//                    attrs.alpha = abs(alpha)
//                }
//        }

        return attributesCopy
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let size = collectionView!.frame.size
        // 计算可见区域的面积
        let rect = CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: size.width, height: size.height)
        let array = super.layoutAttributesForElements(in: rect) ?? []
        // 计算 CollectionView 中点值
        let centerX = proposedContentOffset.x + collectionView!.frame.size.width * 0.5
        // 标记 cell 的中点与 UICollectionView 中点最小的间距
        var minDetal = CGFloat(MAXFLOAT)
        for attrs in array {
            if abs(minDetal) > abs(centerX - attrs.center.x) {
                minDetal = attrs.center.x - centerX
            }
        }

        return CGPoint(x: proposedContentOffset.x , y: proposedContentOffset.y)
    }
}
