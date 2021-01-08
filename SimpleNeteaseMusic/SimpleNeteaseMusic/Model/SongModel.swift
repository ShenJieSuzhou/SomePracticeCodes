//
//  SongModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/1/8.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

struct SongModel {
    let image: String
    let order:Int
    let songName: String
    let singer: String
    let extra: String
    
    init(image: String, order: Int, songName: String, singer: String, extra: String) {
        self.image = image
        self.order = order
        self.songName = songName
        self.singer = singer
        self.extra = extra
    }
}
