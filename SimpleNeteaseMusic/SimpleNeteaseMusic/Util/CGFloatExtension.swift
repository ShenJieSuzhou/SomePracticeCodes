//
//  CGFloatExtension.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/3.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

//let screenWidth = UIScreen.main.bounds.width // max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
//let screenHeight = UIScreen.main.bounds.height // min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
//let screenBounds = UIScreen.main.bounds

extension CGFloat {
        
    func scaleW() -> CGFloat {
        return (screenWidth / 375 * CGFloat(self))
    }
    
    func scaleH() -> CGFloat {
        return (screenHeight / 667 * CGFloat(self))
    }
}
