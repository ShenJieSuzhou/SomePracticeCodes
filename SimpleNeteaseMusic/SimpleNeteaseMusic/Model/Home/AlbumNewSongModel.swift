//
//  AlbumNewSongModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/19.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

class AlbumNewSongModel: HomeViewModelSection {
    var type: HomeViewModelSectionType {
        return .ALBUM_NEW_SONG
    }
    
    var creatives: [Creative]!
    var uiElement: BlockUIElement?
    
    init(creatives: [Creative], ui elements: BlockUIElement) {
        self.creatives = creatives
        self.uiElement = elements
    }
}

