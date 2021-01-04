//
//  JJTableViewHeader.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/26.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SnapKit

public protocol TagSwitchDelegate: NSObject {
    func tagSwitchTo(to index:Int)
}

class JJTableViewHeader: UIView {
    
    // 回调实例
    weak var tagDelegate: TagSwitchDelegate?
    
    // tableView header 名称
    lazy var title: UILabel = {
        let myTitle = UILabel()
        myTitle.textColor = UIColor.darkModeTextColor
        myTitle.font = UIFont.systemFont(ofSize: 22)
        return myTitle
    }()
    
    lazy var mySubtTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.textColor = UIColor.darkModeTextColor
        subTitle.font = UIFont.systemFont(ofSize: 14)
        return subTitle
    }()
        
    // 标签
    var tags: [String]?

    // 查看更多按妞
    lazy var buttom: UIButton = {
        let myButtom = UIButton()
        myButtom.setTitleColor(UIColor.darkModeTextColor, for: .normal)
        
        return myButtom
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func setupUI(title: String, btnName: String) -> Void {
        self.title.text = title
        self.buttom.setTitle(btnName, for: .normal)
        
        let width: CGFloat = self.frame.size.width
        let height: CGFloat = self.frame.size.height
        
        self.addSubview(self.title)
        self.addSubview(self.buttom)
        
        self.title.snp.makeConstraints { (make) in
            make.width.equalTo(width * 0.5)
            make.height.equalTo(height - 20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        self.buttom.snp.makeConstraints { (make) in
            make.width.equalTo(width / 3)
            make.height.equalTo(height - 20)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        // 设置按钮样式
        self.buttom.layer.cornerRadius = 10
        self.buttom.layer.borderColor = UIColor.white.cgColor
        self.buttom.layer.borderWidth = 1
    }
    
    public func setupUIWithButtom(title: String, subTitle: String, buttom: UIButton) -> Void {
        self.title.text = title
        self.mySubtTitle.text = subTitle
        self.buttom = buttom
        
        let width: CGFloat = self.frame.size.width
        let height: CGFloat = self.frame.size.height
        
        self.addSubview(self.title)
        self.addSubview(self.buttom)
        
        self.title.snp.makeConstraints { (make) in
            make.width.equalTo(width * 0.5)
            make.height.equalTo(height - 20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        self.buttom.snp.makeConstraints { (make) in
            make.width.equalTo(width / 3)
            make.height.equalTo(height - 20)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        // 设置按钮样式
        self.buttom.layer.cornerRadius = 10
        self.buttom.layer.borderColor = UIColor.white.cgColor
        self.buttom.layer.borderWidth = 1
    }
    
    public func setupUIWithMutiTags(titles: Array<String>!, btnName: String) -> Void {
        self.buttom.setTitle(btnName, for: .normal)
        let width: CGFloat = self.frame.size.width
        let height: CGFloat = self.frame.size.height
        
        let codeSegmented = JJCustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: 0, height: 0), titles: titles)
        codeSegmented.backgroundColor = .clear
        codeSegmented.delegate = self
        self.addSubview(codeSegmented)
        self.addSubview(self.buttom)
        
        codeSegmented.snp.makeConstraints { (make) in
            make.width.equalTo(width * 0.7)
            make.height.equalTo(height - 20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        self.buttom.snp.makeConstraints { (make) in
            make.width.equalTo(width / 3)
            make.height.equalTo(height - 20)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        // 设置按钮样式
        self.buttom.layer.cornerRadius = 10
        self.buttom.layer.borderColor = UIColor.white.cgColor
        self.buttom.layer.borderWidth = 1
    }
}

extension JJTableViewHeader: JJCustomSegmentedControlDelegate {
    func switchTo(to index: Int) {
        tagDelegate?.tagSwitchTo(to: index)
    }
}
