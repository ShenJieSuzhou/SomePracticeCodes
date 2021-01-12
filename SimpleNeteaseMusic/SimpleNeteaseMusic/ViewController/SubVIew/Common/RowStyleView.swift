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
    
    case SubTitleStyle = 1
    
}

class RowStyleView: UIView {
    
    // 样式
    public var style: RowStyle!
    
    // cover
    private lazy var albumCover: UIImageView = {
        let cover = UIImageView()
        cover.backgroundColor = .clear
        return cover
    }()
    
    // order
    private lazy var orderLabel: UILabel = {
        let order = UILabel()
        order.textColor = .darkModeTextColor
        return order
    }()
    
    
    // middle content
    private lazy var midView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // name
    private lazy var songName: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 14)
        name.textColor = .darkModeTextColor
        name.lineBreakMode = .byTruncatingTail
        return name
    }()
    
    // author
    private lazy var author: UILabel = {
        let author = UILabel()
        author.font = UIFont.systemFont(ofSize: 13)
        author.textColor = .defaultAuthorColor
        author.lineBreakMode = .byTruncatingTail
        return author
    }()
    
    // desc
    private lazy var songDetail: UILabel = {
        let songDetail = UILabel()
        songDetail.font = UIFont.systemFont(ofSize: 13)
        songDetail.textColor = .defaultAuthorColor
        songDetail.lineBreakMode = .byTruncatingTail
        return songDetail
    }()
    
    // trail buttom
    private lazy var playButtom: UIButton  = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "playcircle"), for: .normal)
        return btn
    }()
    
    // trail text
    private lazy var trailText: UILabel = {
        let label = UILabel()
        label.textColor = .darkModeTextColor
        return label
    }()
                   

    convenience init(frame: CGRect, style: RowStyle) {
        self.init(frame: frame)
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
            let rowHeight: Float = Float(self.frame.height)
            let rowWidth: Float = Float(self.frame.size.width)

            // 设置 albumCover 的约束
            self.albumCover.snp.makeConstraints { (make) in
                make.height.equalTo(rowHeight - 10)
                make.width.equalTo(rowHeight - 10)
                make.left.equalToSuperview()
                make.top.equalToSuperview().offset(5)
            }

            // 设置排名的约束
            self.orderLabel.snp.makeConstraints { (make) in
                make.height.equalTo(rowHeight - 10)
                make.width.equalTo(30)
                make.left.equalTo(self.albumCover.snp.right)
                make.top.equalToSuperview().offset(5)
            }

            // 设置 midView 的约束
            self.midView.snp.makeConstraints { (make) in
                make.height.equalTo(rowHeight - 10)
                make.width.equalTo(rowWidth - Float(self.albumCover.frame.size.width) - 30 - 40)
                make.left.equalTo(self.orderLabel.snp.right)
                make.top.equalToSuperview().offset(5)
            }

            let num:Int = Int.random(in: 0..<3)

            // 计算歌名长度， 但不超过最大值，超过部分用省略号代替
            let max_songNameLen = Float(self.midView.frame.size.width * 0.6)
            var songNameLen: Float = 0
            let rect = getStrBoundRect(str: mockdata1[num], font: self.songName.font, constrainedSize: CGSize(width: self.songName.frame.size.width, height: 20))
            songNameLen = Float(rect.width)
            self.songName.snp.makeConstraints { (make) in
                make.width.equalTo((songNameLen > max_songNameLen) ? max_songNameLen : rect.width)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(5)
            }

            // 计算歌手名字长度，但不超过最大值，超过部分用省略号代替
            let max_singerLen = Float(self.midView.frame.size.width * 0.4)
            var singerLen: Float = 0
            let singerRect = getStrBoundRect(str: mockdata2[num], font: self.author.font, constrainedSize: CGSize(width: self.author.frame.size.width, height: 20))
            singerLen = Float(singerRect.width)
            self.author.snp.makeConstraints { (make) in
                make.width.equalTo((singerLen > max_singerLen) ? max_singerLen : singerLen)
                make.centerY.equalToSuperview()
                make.left.equalTo(self.songName.snp.right)
            }
            self.author.text = mockdata2[num]

            // 设置 trailText 的约束
            self.trailText.snp.makeConstraints { (make) in
                make.height.equalTo(rowHeight - 10)
                make.width.equalTo(40)
                make.centerY.equalToSuperview()
                make.left.equalTo(self.midView.snp.right)
            }

            self.trailText.text = "新"

            // 带标题样式
        } else if self.style == RowStyle.SubTitleStyle {
            // Row height
            let rowHeight: Float = Float(self.frame.height)
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
}

// MARK - Configuration
extension RowStyleView {
    
    private func ConfigUI(style: RowStyle) {
        
        // 默认样式
        if style == .NoneStyle {
            self.addSubview(albumCover)
            self.addSubview(orderLabel)
            self.addSubview(midView)
            self.addSubview(trailText)
            
            midView.addSubview(songName)
            midView.addSubview(author)
        } else if style == .SubTitleStyle {
            self.addSubview(albumCover)
            self.addSubview(midView)
            self.addSubview(playButtom)
            
            midView.addSubview(songName)
            midView.addSubview(author)
            midView.addSubview(songDetail)
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
    
    public func setUpRowViewWithDefultStyle(image picUrl: String, order: Int, songName: String, singer: String, style: RowStyle, extra: String){
        self.albumCover.kf.setImage(with: URL(string: picUrl), placeholder: nil, options: nil, completionHandler:  { ( result ) in
            
        })
        
        self.orderLabel.text = String(order)
        self.songName.text = songName
        self.author.text = singer
        self.trailText.text = extra
    }
    
    public func setUpRowViewWithSubTitleStyle(image picUrl: String, order: Int, songName: String, singer: String, style: RowStyle, extra: String){
        
        
    }
}
