//
//  JJCustomSegmentedControl.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/11.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

protocol JJCustomSegmentedControlDelegate: NSObject{
    func switchTo(to index:Int)
}

class JJCustomSegmentedControl: UIView {
    // 定义标题与按钮
    private var buttonTitles:[String]!
    private var viewContainer = [UIView]()

    // 默认颜色与选中后的颜色
    var textColor: UIColor = .defaultAuthorColor
    var selectorTextColor: UIColor = .white
    
    // 回调实例
    weak var delegate: JJCustomSegmentedControlDelegate?
    
    // 当前选中的索引
    public var selectedIndex: Int = 0

    convenience init(frame: CGRect, titles:[String]) {
        self.init(frame:frame)
        self.backgroundColor = .clear
        self.buttonTitles = titles
        configUI()
//        configStackView()
    }
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        updateView()
//    }
    
//    func setButtonTitles(buttonTitles:[String]) {
//        self.buttonTitles = buttonTitles
//        self.updateView()
//    }
    
    func setIndex(index:Int) {
        for view in viewContainer {
            if view.isKind(of: UIButton.self) {
                let button = view as! UIButton
                button.setTitleColor(textColor, for: .normal)
            }
        }
        
        if viewContainer[index].isKind(of: UIButton.self) {
            let button = viewContainer[index] as! UIButton
            button.setTitleColor(textColor, for: .normal)
            selectedIndex = index
            button.setTitleColor(selectorTextColor, for: .normal)
        }
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (viewIndex, view) in viewContainer.enumerated() {
            if view.isKind(of: UIButton.self) {
                let button = view as! UIButton
                button.setTitleColor(textColor, for: .normal)
                
                if button == sender {
                    selectedIndex = viewIndex
                    delegate?.switchTo(to: selectedIndex)
                    button.setTitleColor(selectorTextColor, for: .normal)
                }
            }
        }
    }
}


extension JJCustomSegmentedControl {
//    private func updateView() {
//        createButton()
//        configSelectorView()
//        configStackView()
//    }
    
//    private func configStackView() {
//        var width: CGFloat = 0
//        for view in viewContainer {
//            let w = view.frame.width
//            width += w
//        }
//
//        let stack = UIStackView(arrangedSubviews: viewContainer)
//        stack.frame = CGRect(x: 0, y: 0, width: width+100, height: self.frame.height)
//        stack.backgroundColor = .blue
//        stack.axis = .horizontal
//        self.addSubview(stack)
//
////        stack.snp.makeConstraints { (maker) in
////            maker.width.equalTo(width)
////            maker.height.equalToSuperview()
////        }
//    }
    
//    private func configSelectorView() {
//        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
//        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
//        selectorView.backgroundColor = selectorViewColor
//        addSubview(selectorView)
//    }
    
    private func configUI() {
        // 分割线
//        let seperate = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
//        let seperateLine = UIImageView(frame: CGRect(x: 0, y: 0, width: 2, height: self.frame.height))
//        seperateLine.backgroundColor = UIColor.white
//        seperateLine.backgroundColor = UIColor.clear
//        seperate.addSubview(line)
        
        viewContainer.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        var pX:CGFloat = 0
        let pY:CGFloat = 0
        let padding: CGFloat = 10
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(JJCustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            
            let rect = getStrBoundRect(str: buttonTitle, font: UIFont.systemFont(ofSize: 14), constrainedSize: CGSize.zero)
            button.frame = CGRect(x: pX, y: pY, width: rect.width * 1.2, height: rect.height)
            pX = button.frame.maxX + padding
            
            let seperateLine = UIView(frame: CGRect.zero)
            seperateLine.backgroundColor = UIColor.white
            seperateLine.frame = CGRect(x: pX, y: pY, width: 2, height: rect.height)
            pX = seperateLine.frame.maxX + padding
            viewContainer.append(button)
            viewContainer.append(seperateLine)
            self.addSubview(button)
            self.addSubview(seperateLine)
        }
        viewContainer.removeLast()
        
        let firstBtn = viewContainer[0] as! UIButton
        firstBtn.setTitleColor(selectorTextColor, for: .normal)
    }

    func getStrBoundRect(str:String,font:UIFont,constrainedSize:CGSize,
                             option:NSStringDrawingOptions=NSStringDrawingOptions.usesLineFragmentOrigin)->CGRect{
        let attr = [NSAttributedString.Key.font:font]
        let rect = str.boundingRect(with: constrainedSize, options: option, attributes:attr , context: nil)
        return rect
    }
}
