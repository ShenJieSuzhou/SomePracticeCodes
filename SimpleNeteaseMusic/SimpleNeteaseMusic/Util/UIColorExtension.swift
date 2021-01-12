//
//  UIColorExtension.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/30.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

extension UIColor {
    
    // UIView 背景颜色
    public class var darkModeViewColor:UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    // 文字颜色
    public class var darkModeTextColor: UIColor {
       if #available(iOS 13.0, *) {
           return UIColor{(trainCollection) -> UIColor in
               if trainCollection.userInterfaceStyle == .dark {
                   return .white
               } else {
                   return .black
               }
           }
       } else {
           return .black
       }
    }
    
    // 设置Placeholder文字颜色
    public class var placeholderColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor{(trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 255, green: 255, blue: 255, alpha: 0.25)
                } else {
                    return UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
                }
            }
        } else {
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        }
    }
    
    // 按钮背景颜色
    public class var darkModeMenuColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor{ (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1)
                } else {
                    return .red
                }
            }
        } else {
            return .red
        }
    }
    
    // author color
    public class var defaultAuthorColor: UIColor {
        return UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1)
    }
    
    // cell color
    public class var darkModeCellColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor{ (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
                } else {
                    return .red
                }
            }
        } else {
            return .red
        }
    }
}
