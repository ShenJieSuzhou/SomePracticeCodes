//
//  JJTableViewHeader.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/11/26.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SnapKit

enum MoreStyle {
    case rightArrow
    case refresh
    case play
    case calender
    case none
}

/// headerView 中 多个 view 视图切换
public protocol TagSwitchDelegate: NSObject {
    func tagSwitchTo(to index:Int)
}

/// 首页发现-自定义 HeaderView
class JJTableViewHeader: UIView {
    
    // 回调实例
    weak var tagDelegate: TagSwitchDelegate?
    
    // tableView header 名称
    lazy var title: UILabel = {
        let myTitle = UILabel()
        myTitle.textColor = UIColor.darkModeTextColor
        myTitle.font = UIFont(name: "Helvetica-Bold", size: 17)
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
        myButtom.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return myButtom
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .homeCellColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    /// 设置视图
    /// - Parameters:
    ///   - title: 标题
    ///   - btnName: 按钮文字
    ///   - type: 按钮类型
    public func setupUI(title: String, btnName: String, type: MoreStyle) -> Void {
        let width: CGFloat = self.frame.size.width
        let height: CGFloat = self.frame.size.height
        var moreBtnW: CGFloat = 0
        
        self.addSubview(self.title)
        self.addSubview(self.buttom)
        
        self.title.text = title
        self.buttom.setTitle(btnName, for: .normal)
        
        if type == .rightArrow {
            moreBtnW = 65
            self.buttom.setImage(UIImage(named: "right-arrow"), for: .normal)
            self.buttom.moveImageRightTextCenter(imagePadding: 10)
        } else if type == .play {
            moreBtnW = 65
            self.buttom.setImage(UIImage(named: "play"), for: .normal)
            self.buttom.moveImageLeftTextCenter(imagePadding: 10)
        } else if type == .refresh {
            moreBtnW = 80
            self.buttom.setImage(UIImage(named: "refresh"), for: .normal)
            self.buttom.moveImageLeftTextCenterWithTinySpace(imagePadding: 10)
        } else if type == .calender {
            moreBtnW = 80
            self.buttom.setImage(UIImage(named: "right-arrow"), for: .normal)
            self.buttom.moveImageRightTextCenter(imagePadding: 10)
        } else if type == .none {
            self.buttom.isHidden = true
        }
        
        self.title.snp.makeConstraints { (make) in
            make.width.equalTo(width * 0.7)
            make.height.equalTo(height)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        self.buttom.snp.makeConstraints { (make) in
            make.width.equalTo(moreBtnW)
            make.height.equalTo(height - 20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        
        // Add rounded corners
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.buttom.bounds
        maskLayer.path = UIBezierPath(roundedRect: self.buttom.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        self.buttom.layer.mask = maskLayer

        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1).cgColor
        borderLayer.lineWidth = 1
        borderLayer.frame = self.buttom.bounds
        self.buttom.layer.addSublayer(borderLayer)
    }
    
    /// 设置 headerView 中多个视图
    /// - Parameters:
    ///   - titles: 视图名称，数组形式传入
    ///   - btnName: 按钮文字
    ///   - type: 按钮类型
    public func setupUIWithMutiTags(titles: Array<String>!, btnName: String, type: MoreStyle) -> Void {
        var moreBtnW: CGFloat = 0
        let width: CGFloat = self.frame.size.width
        let height: CGFloat = self.frame.size.height
       
        self.buttom.setTitle(btnName, for: .normal)
        if type == .rightArrow {
            moreBtnW = 60
            self.buttom.setImage(UIImage(named: "right-arrow"), for: .normal)
            self.buttom.moveImageRightTextCenter(imagePadding: 10)
        }
        
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
            make.width.equalTo(moreBtnW)
            make.height.equalTo(height - 20)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        // Add rounded corners
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.buttom.bounds
        maskLayer.path = UIBezierPath(roundedRect: self.buttom.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        self.buttom.layer.mask = maskLayer

        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1).cgColor
        borderLayer.lineWidth = 1
        borderLayer.frame = self.buttom.bounds
        self.buttom.layer.addSublayer(borderLayer)
    }
}

extension JJTableViewHeader: JJCustomSegmentedControlDelegate {
    
    /// 视图切换事件
    /// - Parameter index: 切换视图的当前索引
    func switchTo(to index: Int) {
        tagDelegate?.tagSwitchTo(to: index)
    }
}

