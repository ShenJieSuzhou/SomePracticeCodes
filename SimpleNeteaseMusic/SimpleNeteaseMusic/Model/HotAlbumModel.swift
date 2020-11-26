//
//  HotAlbumModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/26.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

class HotAlbumModel: NSObject {
 
    var albumPic: String?
    var albumDesc: String?
    var views: String?
    
    init(image: String, desc: String, views: String) {
        self.albumPic = image
        self.albumDesc = desc
        self.views = views
    }
}
