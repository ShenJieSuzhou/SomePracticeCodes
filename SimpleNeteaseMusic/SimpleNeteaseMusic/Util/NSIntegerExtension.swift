//
//  NSIntegerExtension.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/3.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

let screenBounds = UIScreen.main.bounds
let screenWidth = UIScreen.main.bounds.width // max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
let screenHeight = UIScreen.main.bounds.height // min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)

extension NSInteger{
    
    func scaleW() -> CGFloat {
        return (screenWidth / 414 * CGFloat(self))
    }
    
    func scaleH() -> CGFloat {
        return (screenHeight / 667 * CGFloat(self))
    }
}

// 根据屏幕尺寸进行缩放
//static func UIAdapter (param: CGFloat) -> NSInteger{
//    let scale = 414 / JJSCREEN_WIDTH
//    return (NSInteger)param / scale
//}
//static inline NSInteger UIAdapter (float x){
//    CGFloat scale = 414 / SCREEN_WIDTH; // 因为视觉稿是 iphone6P 是 414 宽度
//    return (NSInteger)x /scale;
//}
//
//static inline CGRect UIRectAdapter(x, y, width, height){
//    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
//}
