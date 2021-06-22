//
//  HomeViewModeSection.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

/// 数据模型继承此协议
protocol HomeViewModelSection {
    var type: HomeViewModelSectionType { get }
    var rowCount: Int { get }
    var rowHeight: CGFloat { get }
    var frame: CGRect { get set }
}

extension HomeViewModelSection {
    var rowCount: Int {
        return 1
    }
}
