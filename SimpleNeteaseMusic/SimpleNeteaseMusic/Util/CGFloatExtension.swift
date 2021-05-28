//
//  CGFloatExtension.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/3.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.width // max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
let kSreenHeight = UIScreen.main.bounds.height // min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
let kSreenBounds = UIScreen.main.bounds

let kLeftMargin: CGFloat = 20.0
let kTopMargin: CGFloat = 20.0

let scaleW: CGFloat = CGFloat(kScreenWidth / 414)
let scaleH: CGFloat = CGFloat(kSreenHeight / 667)

extension CGFloat {
        
//    func scaleW() -> CGFloat {
//        return (screenWidth / 414 * CGFloat(self))
//    }
//
//    func scaleH() -> CGFloat {
//        return (screenHeight / 667 * CGFloat(self))
//    }
}
