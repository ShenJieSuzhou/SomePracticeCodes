//
//  HomeCircleMenusModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/13.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct HomeCircleMenu: Codable {
    let code: Int
    let data: [Datum]
    let message: String
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let name: String
    let iconURL: String
    let url: String
    let skinSupport: Bool
    let homepageMode: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case iconURL = "iconUrl"
        case url, skinSupport, homepageMode
    }
}
