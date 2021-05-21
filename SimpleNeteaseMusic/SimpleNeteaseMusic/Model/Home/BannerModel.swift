//
//  BannerModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/19.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

class BannerModel: HomeViewModelSection {
    var type: HomeViewModelSectionType {
        return .BANNER
    }
    
    var rowCount: Int{
        return 1
    }
    
    var rowHeight: Int = 0
    var banners: [Banner]!
    
    init(banners: [Banner]) {
        self.banners = banners
    }
}
