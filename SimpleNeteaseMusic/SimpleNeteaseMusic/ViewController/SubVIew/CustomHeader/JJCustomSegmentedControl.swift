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
    private var buttons: [UIView]!

    // 默认颜色与选中后的颜色
    var textColor: UIColor = .defaultAuthorColor
    var selectorTextColor: UIColor = .white
    
    // 回调实例
    weak var delegate: JJCustomSegmentedControlDelegate?
    
    // 当前选中的索引
    public var selectedIndex: Int = 0

    convenience init(frame: CGRect, titles:[String]) {
        self.init(frame:frame)
        self.buttonTitles = titles
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = .clear
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(index:Int) {
        for (viewIndex, view) in buttons.enumerated() {
            if view.isKind(of: UIButton.self) {
                let button = view as! UIButton
                button.setTitleColor(textColor, for: .normal)
            }
        }
        
        if buttons[index].isKind(of: UIButton.self) {
            let button = buttons[index] as! UIButton
            button.setTitleColor(textColor, for: .normal)
            selectedIndex = index
            button.setTitleColor(selectorTextColor, for: .normal)
        }
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (viewIndex, view) in buttons.enumerated() {
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
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
//        var width: CGFloat!
//        for (viewIndex, view) in buttons.enumerated() {
//            let w = view.frame.width
//            width += w
//        }
        
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
////        stack.alignment = .fill
//        stack.distribution = .equalCentering
////        stack.spacing = 10
        addSubview(stack)
        
        stack.snp.makeConstraints { (maker) in
//            maker.width.equalTo(width)
            maker.height.equalToSuperview()
        }
    }
    
    private func configSelectorView() {
//        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
//        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
//        selectorView.backgroundColor = selectorViewColor
//        addSubview(selectorView)
    }
    
    private func createButton() {
        let seperate = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        seperate.backgroundColor = UIColor.white
        
        buttons = [UIView]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            let rect = getStrBoundRect(str: buttonTitle, font: button.titleLabel!.font, constrainedSize: CGSize(width: button.frame.size.width, height: self.frame.height))
            button.frame = rect
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(JJCustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
            buttons.append(seperate)
        }
        buttons.removeLast()
        
        let firstBtn = buttons[0] as! UIButton
        firstBtn.setTitleColor(selectorTextColor, for: .normal)
    }

    func getStrBoundRect(str:String,font:UIFont,constrainedSize:CGSize,
                             option:NSStringDrawingOptions=NSStringDrawingOptions.usesLineFragmentOrigin)->CGRect{
        let attr = [NSAttributedString.Key.font:font]
        let rect = str.boundingRect(with: constrainedSize, options: option, attributes:attr , context: nil)
        return rect
    }
}
