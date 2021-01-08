//
//  RankModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/1/8.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

struct RankModel {
    let title: String
    let rankList:[SongModel]
    
    init(title: String, rankList: [SongModel]) {
        self.title = title
        self.rankList = rankList
    }
}
