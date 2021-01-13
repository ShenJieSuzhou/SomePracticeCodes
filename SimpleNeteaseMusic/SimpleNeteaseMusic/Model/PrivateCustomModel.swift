//
//  PrivateCustomModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/1/13.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

struct PrivateCustomModel {
    let privateList:[SongModel]
    
    init(songsList: [SongModel]) {
        self.privateList = songsList
    }
}
