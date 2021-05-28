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
        self.frame = CGRect.zero
        self.rowHeight = 0
    }
}
