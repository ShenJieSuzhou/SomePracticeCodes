//
//  AlbumNewSongModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/19.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class AlbumNewSongModel: HomeViewModelSection {
    var rowHeight: CGFloat
    
    var frame: CGRect
    
    var type: HomeViewModelSectionType {
        return .ALBUM_NEW_SONG
    }
    
    var rowCount: Int{
        return 1
    }

    var creatives: [Creative]!
    var uiElement: BlockUIElement?
    
    init(creatives: [Creative], ui elements: BlockUIElement) {
        self.creatives = creatives
        self.uiElement = elements
        self.frame = AlbumNewSongModel.caculateFrame()
        self.rowHeight = self.frame.height
    }
    
    /// 根据模型计算 View frame
    class func caculateFrame() -> CGRect {
        let height: CGFloat = sectionA_height * CGFloat(scaleW)
        let width: CGFloat = CGFloat(kScreenWidth)
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}

