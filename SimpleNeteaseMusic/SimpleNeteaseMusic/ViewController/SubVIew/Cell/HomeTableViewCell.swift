//
//  HomeTableViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class BannerCell: UITableViewCell {
     
}


/// UITableViewCell 的基类
class BaseViewCell: UITableViewCell {
    
}

class ScrollBannerCell: BaseViewCell {
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? BannerModel else {
                return
            }
            
        }
    }
}
