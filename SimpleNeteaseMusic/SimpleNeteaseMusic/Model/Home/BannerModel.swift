//
//  BannerModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/19.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class BannerModel: HomeViewModelSection {
    var frame: CGRect
    
    var type: HomeViewModelSectionType {
        return .BANNER
    }
    
    var rowCount: Int{
        return 1
    }
    
    var rowHeight:CGFloat
    
    var banners: [Banner]!
    
    init(banners: [Banner]) {
        self.banners = banners
        self.frame = BannerModel.caculateFrame()
        self.rowHeight = self.frame.size.height
    }
    
    /// 根据模型计算 View frame
    class func caculateFrame() -> CGRect {
        let height: Double = 120 * Double(scaleW)
        let width: Double = Double(kScreenWidth)
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}


