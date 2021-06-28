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
            return UIColor{(trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return .systemBackground
                } else {
                    return UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
                }
            }
        } else {
            return .systemBackground
        }
    }
    
    // Cell 背景颜色
    public class var homeCellColor:UIColor {
        if #available(iOS 13.0, *) {
            return UIColor{(trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
                } else {
                    return .white
                }
            }
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
                    return UIColor(red: 45/255, green: 25/255, blue: 23/255, alpha: 1)
                } else {
                    return UIColor(red: 255/255, green: 243/255, blue: 245/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 255/255, green: 243/255, blue: 245/255, alpha: 1)
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
    
    /// circel menu color
    public class var dragonBallColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor{ (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 214/255, green: 56/255, blue: 57/255, alpha: 1)
                } else {
                    return UIColor(red: 253/255, green: 79/255, blue: 79/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 253/255, green: 79/255, blue: 79/255, alpha: 1)
        }
    }
    
    /// separtor line color
    public class var separtorColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor{ (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
                } else {
                    return UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        }
    }
}
