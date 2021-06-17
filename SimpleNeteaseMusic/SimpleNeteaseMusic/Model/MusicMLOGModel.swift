//
//  MusicMLOGViewModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class MusicMLOGModel: HomeViewModelSection {
    var rowHeight: CGFloat
    
    var frame: CGRect
    
    
    var type: HomeViewModelSectionType {
        return .MUSIC_MLOG
    }
    
    var rowCount: Int{
        return 1
    }
    
    var uiElement: BlockUIElement?
    var mLog: [EXTInfoElement]!
    
    init(mLog: [EXTInfoElement], ui elements: BlockUIElement) {
        self.mLog = mLog
        self.uiElement = elements
        self.frame = MusicMLOGModel.caculateFrame()
        self.rowHeight = self.frame.size.height
    }
    
    /// 根据模型计算 View frame
    class func caculateFrame() -> CGRect {
        let height: CGFloat = sectionA_height * CGFloat(scaleW)
        let width: CGFloat = CGFloat(kScreenWidth)
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}
