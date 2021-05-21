//
//  OfficialPlaylistViewModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

class OfficialPlaylistModel: HomeViewModelSection {
    var type: HomeViewModelSectionType {
        return .OFFICIAL_PLAYLIST
    }
    
    var rowCount: Int{
        return 1
    }
    
    var rowHeight: Int = 0
    var creatives: [Creative]!
    var uiElement: BlockUIElement?
    
    init(creatives: [Creative], ui elements: BlockUIElement) {
        self.creatives = creatives
        self.uiElement = elements
    }
}
