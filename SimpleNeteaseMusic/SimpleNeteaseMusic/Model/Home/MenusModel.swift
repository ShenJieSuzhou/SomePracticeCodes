//
//  MenusModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/20.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

class MenusModel: HomeViewModelSection {
    var type: HomeViewModelSectionType {
        return .BANNER
    }
    
    var data: [Datum]!
    
    init(data: [Datum]) {
        self.data = data
    }
}
