//
//  HomeViewModeSection.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

protocol HomeViewModelSection {
    var type: HomeViewModelSectionType { get }
    var rowCount: Int { get }
}

extension HomeViewModelSection {
    var rowCount: Int {
        return 1
    }
}
