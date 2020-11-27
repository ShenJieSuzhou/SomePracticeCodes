//
//  HotAlbumModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/26.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

// MARK: - HotAlbum
struct HotAlbum: Codable {
    let hasTaste: Bool
    let code, category: Int
    let result: [HotListResult]
}

// MARK: - Result
struct HotListResult: Codable {
    let id, type: Int
    let name, copywriter: String
    let picURL: String
    let canDislike: Bool
    let trackNumberUpdateTime, playCount, trackCount: Int
    let highQuality: Bool
    let alg: String

    enum CodingKeys: String, CodingKey {
        case id, type, name, copywriter
        case picURL = "picUrl"
        case canDislike, trackNumberUpdateTime, playCount, trackCount, highQuality, alg
    }
}

//class HotAlbumModel: NSObject {
//
//    var albumPic: String?
//    var albumDesc: String?
//    var views: String?
//
//    init(picUrl: String, name: String, playCount: String) {
//        self.albumPic = picUrl
//        self.albumDesc = name
//        self.views = playCount
//    }
//}
