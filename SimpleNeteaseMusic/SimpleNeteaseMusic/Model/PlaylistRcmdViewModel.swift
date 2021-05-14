//
//  File.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

class PlaylistRcmdViewModel: HomeViewModelSection {
    var type: HomeViewModelSectionType {
        return .PLAYLIST_RCMD
    }
    
    var sectionTitle: String!
    var creatives: Creative!
    
    init(creatives: Creative) {
        self.creatives = creatives
    }
    
}
