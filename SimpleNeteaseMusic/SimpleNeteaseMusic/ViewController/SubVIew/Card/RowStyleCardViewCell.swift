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
let mockdata2:[String] = ["Jason Derulo/Jacob Kasher Hindlin", "Billie Eilish", "Jawsh 685 / Jason Derulo"]
let mockdata3:[String] = ["Thompson/Neave Applebaum/Robert Michael Nelson Harvey/Uzo Eminike", "I can't seem to focus", "Savage love"]
let mockdata4:[String] = ["http://p2.music.126.net/1gNcBmzdIaQtU00Dvp_TvQ==/109951163912081772.jpg", "http://p1.music.126.net/W2bXXvZlKrK455hjt1v_Kw==/109951163714852966.jpg", "http://p2.music.126.net/PsONIoIzCJ-9gPCAeq9ahw==/19115009649498152.jpg"]

class RowView: UIView {
    
    // cover
    lazy var albumCover: UIImageView = {
        let cover = UIImageView()
        cover.backgroundColor = .clear
        return cover
    }()
    
    
    // middle content
    lazy var midView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkModeViewColor
        return view
    }()
    
    // name
    lazy var songName: UILabel = {
        let name = UILabel()
        name.text = ""
        name.font = UIFont.systemFont(ofSize: 14)
        name.textColor = .darkModeTextColor
        return name
    }()
    
    // author
    lazy var author: UILabel = {
        let author = UILabel()
        author.text = ""
        author.font = UIFont.systemFont(ofSize: 13)
        author.textColor = .defaultAuthorColor
        return author
    }()
    
    // desc
    lazy var songDetail: UILabel = {
        let songDetail = UILabel()
        songDetail.text = ""
        songDetail.font = UIFont.systemFont(ofSize: 13)
        songDetail.textColor = .defaultAuthorColor
        return songDetail
    }()
    
    // paly buttom
    lazy var playButtom: UIButton  = {
        let btn = UIButton()
        return btn
    }()
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        // 绘制
        self.addSubview(self.albumCover)
        self.addSubview(self.midView)
        self.addSubview(self.playButtom)
        
        self.midView.addSubview(self.songName)
        self.midView.addSubview(self.author)
        self.midView.addSubview(self.songDetail)
        
        // Row height
        let rowHeight: Float = ROW_HEIGHT
        let rowWidth: Float = Float(self.frame.size.width)
        
        // 设置 albumCover 的约束
        self.albumCover.snp.makeConstraints { (make) in
            make.height.equalTo(rowHeight - 10)
            make.width.equalTo(rowHeight - 10)
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        // 设置 midView 的约束
        self.midView.snp.makeConstraints { (make) in
            make.height.equalTo(rowHeight - 10)
            make.width.equalTo(rowWidth - Float(self.albumCover.frame.size.width) - 40)
            make.left.equalTo(self.albumCover.snp.right)
            make.top.equalToSuperview().offset(5)
        }
        
        let num:Int = Int.random(in: 0..<3)
        
        // 计算歌名长度， 但不超过最大值，超过部分用省略号代替
        let max_songNameLen = rowWidth * 0.6
        let songNameLen: Float = 0
        let rect = getStrBoundRect(str: mockdata1[num] ?? "", font: self.songName.font, constrainedSize: CGSize(width: self.songName.frame.size.width, height: 20))
        
        // 计算歌手名字长度，但不超过最大值，超过部分用省略号代替
        let max_singerLen = rowWidth * 0.4
        let singerLen: Float = 0
        
        // 计算专辑简介长度，但不超过最大值，超过部分用省略号代替
        let max_albumDetailLen = rowWidth
        let albumDetailLen: Float = 0
        
        
        
        // 设置 playButtom 的约束
        self.playButtom.snp.makeConstraints { (make) in
            make.height.equalTo(rowHeight - 10)
            make.width.equalTo(40)
            make.centerY.equalToSuperview()
            make.left.equalTo(self.midView.snp.right)
        }
        
        
        
    }
    
    func updateUI(mImgUrl: String, mSongname: String, mAuthor: String, mSongDetail: String) -> Void {
        
    }
    
    
    /*
    * 获取字符串边框
    */
    func getStrBoundRect(str:String,font:UIFont,constrainedSize:CGSize,
                             option:NSStringDrawingOptions=NSStringDrawingOptions.usesLineFragmentOrigin)->CGRect{
        let attr = [NSAttributedString.Key.font:font]
        let rect=str.boundingRect(with: constrainedSize, options: option, attributes:attr , context: nil)
        return rect
    }
    
}

class RowStyleCardViewCell: UICollectionViewCell {
    
    lazy var rowView1: RowView = {
       let view = RowView()
        return view
    }()
    
    lazy var rowView2: RowView = {
       let view = RowView()
        return view
    }()
    
    
    lazy var rowView3: RowView = {
       let view = RowView()
        return view
    }()

    


}
