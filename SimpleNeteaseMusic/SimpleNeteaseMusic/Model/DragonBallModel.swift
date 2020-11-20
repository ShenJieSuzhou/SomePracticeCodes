//
//  DragonBallModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/20.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

class DragonBallModel: NSObject {
    var menuIcon: String?
    var menuTitle: String?
    
    init(menuIcon: String, title: String) {
        self.menuIcon = menuIcon
        self.menuTitle = title
    }
}
