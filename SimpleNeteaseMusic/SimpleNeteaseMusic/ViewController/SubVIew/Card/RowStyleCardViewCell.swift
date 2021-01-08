//
//  RowStyleCardViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/2.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import SnapKit

// 默认的行高
let ROW_HEIGHT:Float = 60.0

let mockdata1:[String] = ["Savage Love (Laxed - Siren Beat)", "my future", "Savage Love (Laxed - Siren Beat)"]
let mockdata2:[String] = [" - Jason Derulo/Jacob Kasher Hindlin", " - Billie Eilish", " - Jawsh 685 / Jason Derulo"]
let mockdata3:[String] = ["Thompson/Neave Applebaum/Robert Michael Nelson Harvey/Uzo Eminike", "I can't seem to focus", "Savage love"]
let mockdata4:[String] = ["http://p2.music.126.net/1gNcBmzdIaQtU00Dvp_TvQ==/109951163912081772.jpg", "http://p1.music.126.net/W2bXXvZlKrK455hjt1v_Kw==/109951163714852966.jpg", "http://p2.music.126.net/PsONIoIzCJ-9gPCAeq9ahw==/19115009649498152.jpg"]


class RowStyleCardViewCell: UICollectionViewCell {
    lazy var rowView1: RowStyleView = {
       let view = RowStyleView()
//        view.updateUI(mImgUrl: "", mSongname: "", mAuthor: "", mSongDetail: "")
        return view
    }()
    
    lazy var rowView2: RowStyleView = {
       let view = RowStyleView()
//        view.updateUI(mImgUrl: "", mSongname: "", mAuthor: "", mSongDetail: "")
        return view
    }()
    
    
    lazy var rowView3: RowStyleView = {
       let view = RowStyleView()
//        view.updateUI(mImgUrl: "", mSongname: "", mAuthor: "", mSongDetail: "")
        return view
    }()

    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        // 构建 Cell UI
        self.addSubview(rowView1)
        self.addSubview(rowView2)
        self.addSubview(rowView3)
        
        // 每个 row 的行高
        let rowHeight: Float = Float(self.frame.size.height) / 3
        
        // 约束
        self.rowView1.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(rowHeight)
        }
        
        self.rowView2.snp.makeConstraints { (make) in
            make.top.equalTo(self.rowView1.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(rowHeight)
        }
        
        self.rowView3.snp.makeConstraints { (make) in
            make.top.equalTo(self.rowView2.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(rowHeight)
        }
    }
}
