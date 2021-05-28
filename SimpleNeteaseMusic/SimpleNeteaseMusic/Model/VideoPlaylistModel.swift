//
//  VideoPlaylistViewModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class VideoPlaylistModel: HomeViewModelSection {
    var rowHeight: CGFloat
    
    var frame: CGRect
    
    var type: HomeViewModelSectionType {
        return .VIDEO_PLAYLIST
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
