//
//  MusicCalendarViewModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class MusicCalendarModel: HomeViewModelSection {
    var rowHeight: CGFloat
    
    var frame: CGRect
    
    var type: HomeViewModelSectionType {
        return .MUSIC_CALENDAR
    }
    
    var rowCount: Int{
        return 1
    }
    
    var creatives: [Creative]!
    var uiElement: BlockUIElement?
    
    init(creatives: [Creative], ui elements: BlockUIElement) {
        self.creatives = creatives
        self.uiElement = elements
        self.frame = CGRect.zero
        self.rowHeight = 0
    }
}
