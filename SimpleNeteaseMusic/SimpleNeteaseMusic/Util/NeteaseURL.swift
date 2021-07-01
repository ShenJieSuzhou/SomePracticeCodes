//
//  NeteaseURL.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/7/1.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

enum NeteaseURL: String {
    case Home = "homepage/block/page"
    case Menu = "homepage/dragon/ball"
    
    public var urlString: String {
        "\(Constant.baseURL)\(self.rawValue)"
    }
}
