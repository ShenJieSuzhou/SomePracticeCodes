//
//  RowStyleView.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/1/6.
//  Copyright © 2021 shenjie. All rights reserved.
//
import UIKit

public enum RowStyle : Int {
    
    case NoneStyle = 0
    
    case HeaderTitleStyle = 1
    
}

class RowStyleView: UIView {
    
    // 样式
    public var style: RowStyle!
    
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
        name.font = UIFont.systemFont(ofSize: 14)
        name.textColor = .darkModeTextColor
        name.lineBreakMode = .byTruncatingTail
        return name
    }()
    
    // author
    lazy var author: UILabel = {
        let author = UILabel()
        author.font = UIFont.systemFont(ofSize: 13)
        author.textColor = .defaultAuthorColor
        author.lineBreakMode = .byTruncatingTail
        return author
    }()
    
    // desc
    lazy var songDetail: UILabel = {
        let songDetail = UILabel()
        songDetail.font = UIFont.systemFont(ofSize: 13)
        songDetail.textColor = .defaultAuthorColor
        songDetail.lineBreakMode = .byTruncatingTail
        return songDetail
    }()
    
    // paly buttom
    lazy var playButtom: UIButton  = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "playcircle"), for: .normal)
        return btn
    }()
                      
    init(frame: CGRect, style: RowStyle) {
        super.init(frame: frame)
        self.style = style
        ConfigUI(style: self.style)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK - LifeCycle
extension RowStyleView {
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        // 默认样式
        if self.style == RowStyle.NoneStyle {
            
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
            var songNameLen: Float = 0
            let rect = getStrBoundRect(str: mockdata1[num], font: self.songName.font, constrainedSize: CGSize(width: self.songName.frame.size.width, height: 20))
            songNameLen = Float(rect.width)
            self.songName.snp.makeConstraints { (make) in
                make.width.equalTo((songNameLen > max_songNameLen) ? max_songNameLen : rect.width)
                make.left.equalToSuperview().offset(5)
                make.top.equalToSuperview()
            }
            self.songName.text = mockdata1[num]
            
            // 计算歌手名字长度，但不超过最大值，超过部分用省略号代替
            let max_singerLen = rowWidth * 0.4
            var singerLen: Float = 0
            let singerRect = getStrBoundRect(str: mockdata2[num], font: self.author.font, constrainedSize: CGSize(width: self.author.frame.size.width, height: 20))
            singerLen = Float(singerRect.width)
            self.author.snp.makeConstraints { (make) in
                make.width.equalTo((singerLen > max_singerLen) ? max_singerLen : singerLen)
                make.left.equalTo(self.songName.snp.right)
                make.top.equalToSuperview()
            }
            self.author.text = mockdata2[num]
            
            // 计算专辑简介长度，但不超过最大值，超过部分用省略号代替
            //        let max_albumDetailLen = rowWidth
            var albumDetailLen: Float = 0
            let detailRect = getStrBoundRect(str: mockdata3[num], font: self.songDetail.font, constrainedSize: CGSize(width: self.songDetail.frame.size.width, height: 20))
            albumDetailLen = Float(detailRect.width)
            self.songDetail.snp.makeConstraints { (make) in
                make.width.equalTo(albumDetailLen)
                make.left.equalToSuperview().offset(5)
                make.top.equalTo(self.songName.snp.bottom).offset(5)
            }
            self.songDetail.text = mockdata3[num]
            
            // 设置 playButtom 的约束
            self.playButtom.snp.makeConstraints { (make) in
                make.height.equalTo(rowHeight - 10)
                make.width.equalTo(40)
                make.centerY.equalToSuperview()
                make.left.equalTo(self.midView.snp.right)
            }
            // 带标题样式
        } else if self.style == RowStyle.HeaderTitleStyle {
            
            
            
        }
    }
    
    /*
    * 获取字符串边框
    */
    private func getStrBoundRect(str:String,font:UIFont,constrainedSize:CGSize,
                             option:NSStringDrawingOptions=NSStringDrawingOptions.usesLineFragmentOrigin)->CGRect{
        let attr = [NSAttributedString.Key.font:font]
        let rect = str.boundingRect(with: constrainedSize, options: option, attributes:attr , context: nil)
        return rect
    }
    
    public func setUpRowViewWithDefultStyle(image picUrl: String, order: Int, songName: String, singer: String, style: RowStyle, extra: String){

    }
    
    public func setUpRowViewWithHeaderStyle(image picUrl: String, order: Int, songName: String, singer: String, style: RowStyle, extra: String){
        
        
    }
}

// MARK - Configuration
extension RowStyleView {
    
    private func ConfigUI(style: RowStyle) {
        
        // 默认样式
        if style == .NoneStyle {
            self.addSubview(self.albumCover)
            self.addSubview(self.midView)
            self.addSubview(self.playButtom)
            
            self.midView.addSubview(self.songName)
            self.midView.addSubview(self.author)
            self.midView.addSubview(self.songDetail)
        } else if style == .HeaderTitleStyle {
            
            
        }
        
        
    }
    
    /// 更新 UI
    /// - Parameters:
    ///   - mImgUrl: 图片地址
    ///   - mSongname: 歌曲名
    ///   - mAuthor: 歌手
    ///   - mSongDetail: 详情
    /// - Returns:
    private func updateUI(mImgUrl: String, mSongname: String, mAuthor: String, mSongDetail: String) -> Void {
        let num:Int = Int.random(in: 0..<3)
        let url = mockdata4[num]
        self.albumCover.kf.setImage(with: URL(string: url), placeholder: nil, options: nil, completionHandler:  { ( result ) in
            
        })
    }
}
