//
//  JJTableViewHeader.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/26.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SnapKit

class JJTableViewHeader: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // tableView header 名称
    lazy var title: UILabel = {
        let myTitle = UILabel()
        myTitle.textColor = UIColor.white
        myTitle.font = UIFont.systemFont(ofSize: 22)
        return myTitle
    }()

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
    
    func setupUI(title: String, btnName: String) -> Void {
        self.title.text = title
        self.buttom.setTitle(btnName, for: .normal)
    }
}
