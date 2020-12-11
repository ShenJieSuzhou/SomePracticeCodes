//
//  JJTableViewHeader.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/26.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SnapKit

//public protocol TagSwitchDelegate:  {
//    <#requirements#>
//}

class JJTableViewHeader: UIView {

//    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
//        didSet{
//            interfaceSegmented.setButtonTitles(buttonTitles: ["OFF","HTTP","AUTO"])
//            interfaceSegmented.selectorViewColor = .orange
//            interfaceSegmented.selectorTextColor = .orange
//        }
//    }
    
//    let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50), buttonTitle: ["OFF","HTTP","AUTO"])
//    codeSegmented.backgroundColor = .clear
//    view.addSubview(codeSegmented)
    
    // tableView header 名称
    lazy var title: UILabel = {
        let myTitle = UILabel()
        myTitle.textColor = UIColor.white
        myTitle.font = UIFont.systemFont(ofSize: 22)
        return myTitle
    }()
    
    lazy var mySubtTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.textColor = UIColor.white
        subTitle.font = UIFont.systemFont(ofSize: 14)
        return subTitle
    }()
        
    // 标签
    var tagButtoms: [UIButton]?

    // 查看更多按妞
    lazy var buttom: UIButton = {
        let myButtom = UIButton()
        myButtom.setTitleColor(UIColor.white, for: .normal)
        
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
    
    public func setupUI(title: String, btnName: String) -> Void {
        self.title.text = title
        self.buttom.setTitle(btnName, for: .normal)
    }
    
    public func setupUIWithButtom(title: String, subTitle: String, buttom: UIButton) -> Void {
        self.title.text = title
        self.mySubtTitle.text = subTitle
        self.buttom = buttom
    }
    
    public func setupUIWithMutiTags(titles: Array<String>!) -> Void {
        for item in titles {
            let buttom:UIButton = UIButton(type: .custom)
            buttom.setTitle(item, for: .normal)
        }
    }
}
