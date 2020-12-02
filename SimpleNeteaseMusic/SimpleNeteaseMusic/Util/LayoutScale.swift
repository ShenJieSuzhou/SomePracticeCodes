//
//  LayoutScale.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/2.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

//class LayoutScale: NSObject {
//
//}


// 是否为横屏的宏
//#define IS_LANDSCAPE (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
//
//// 根据横屏竖屏取屏幕宽高
//#define SCREEN_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
//#define SCREEN_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

let JJSCREEN_WIDTH = UIScreen.main.bounds.size.width

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
