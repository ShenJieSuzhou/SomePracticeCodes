//
//  HomeTableViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import UIKit

class BannerCell: UITableViewCell {
     
}


/// UITableViewCell 的基类
class BaseViewCell: UITableViewCell {
    
}

class ScrollBannerCell: BaseViewCell {
    class var identifier: String {
          return String(describing: self)
    }
    
    var scrollBanner = JJNewsBanner()
    
    var item: HomeViewModelSection? {
        didSet {
            guard let item = item as? BannerModel else {
                return
            }
            self.setupUI(model: item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /// 初始化
        scrollBanner.frame = CGRect.zero
        self.contentView.addSubview(scrollBanner)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollBanner.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setupUI(model: BannerModel) {
        scrollBanner.updateUI(model: model, placeholderImage: UIImage(named: ""))
    }
}
