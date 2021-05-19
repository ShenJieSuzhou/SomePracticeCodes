//
//  VideoPlaylistViewModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

class VideoPlaylistModel: HomeViewModelSection {
    var type: HomeViewModelSectionType {
        return .VIDEO_PLAYLIST
    }
    
    var creatives: [Creative]!
    var uiElement: BlockUIElement?
    
    init(creatives: [Creative], ui elements: BlockUIElement) {
        self.creatives = creatives
        self.uiElement = elements
    }
}
