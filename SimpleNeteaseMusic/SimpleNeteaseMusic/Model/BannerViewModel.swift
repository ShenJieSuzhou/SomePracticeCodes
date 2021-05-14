//
//  BannerViewModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

class BannerViewModel: HomeViewModelSection {
    var type: HomeViewModelSectionType {
        return .BANNER
    }
    
    var sectionTitle: String!
    var banners: [Banner]!
    
    init(banners: [Banner]) {
        self.banners = banners
    }
    
    
    
}
