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
    private var buttons: [UIButton]!

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
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                selectedIndex = buttonIndex
                delegate?.switchTo(to: selectedIndex)
                btn.setTitleColor(selectorTextColor, for: .normal)
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
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configSelectorView() {
//        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
//        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
//        selectorView.backgroundColor = selectorViewColor
//        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(JJCustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
}
