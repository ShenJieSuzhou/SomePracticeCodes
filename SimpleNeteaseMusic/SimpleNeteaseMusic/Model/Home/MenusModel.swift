//
//  MenusModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/20.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class MenusModel: HomeViewModelSection {
    var rowHeight: CGFloat
    
    var frame: CGRect
    
    var type: HomeViewModelSectionType {
        return .MENUS
    }
    
    var rowCount: Int{
        return 1
    }
    
    var data: [Datum]!
    
    init(data: [Datum]) {
        self.data = data
        self.frame = MenusModel.caculateFrame()
        self.rowHeight = self.frame.size.height
    }
    
    /// 根据模型计算 View frame
    class func caculateFrame() -> CGRect {
        let height: CGFloat = sectionC_height * CGFloat(scaleW)
        let width: CGFloat = CGFloat(kScreenWidth)
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}
