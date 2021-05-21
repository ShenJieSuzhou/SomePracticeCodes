//
//  MusicMLOGViewModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

class MusicMLOGModel: HomeViewModelSection {
    var type: HomeViewModelSectionType {
        return .MUSIC_MLOG
    }
    
    var rowCount: Int{
        return 1
    }
    
    var rowHeight: Int = 0
    var uiElement: BlockUIElement?
    var mLog: [EXTInfoElement]!
    
    init(mLog: [EXTInfoElement], ui elements: BlockUIElement) {
        self.mLog = mLog
        self.uiElement = elements
    }
}
