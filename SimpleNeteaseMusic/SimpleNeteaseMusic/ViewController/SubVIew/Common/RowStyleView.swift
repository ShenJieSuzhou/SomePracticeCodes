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
    
    // viewWidth
    private var viewWidth: CGFloat!
    
    // cover
    private lazy var albumCover: UIImageView = {
        let cover = UIImageView()
        cover.backgroundColor = .clear
        cover.layer.cornerRadius = 6.0
        cover.layer.masksToBounds = true
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
        viewWidth = frame.width
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
            let rowWidth: Float = Float(viewWidth)

            // 设置 albumCover 的约束
            self.albumCover.snp.makeConstraints { (make) in
                make.height.equalTo(rowHeight - 10)
                make.width.equalTo(rowHeight - 10)
                make.left.equalToSuperview().offset(10)
                make.top.equalToSuperview().offset(5)
            }

            // 设置排名的约束
            self.orderLabel.snp.makeConstraints { (make) in
                make.height.equalTo(rowHeight - 10)
                make.width.equalTo(20)
                make.left.equalTo(self.albumCover.snp.right).offset(10)
                make.top.equalToSuperview().offset(5)
            }

            // 设置 midView 的约束
            self.midView.snp.makeConstraints { (make) in
                make.height.equalTo(rowHeight - 10)
                make.width.equalTo(rowWidth - Float(self.albumCover.frame.size.width) - 30 - 40 - 20)
                make.left.equalTo(self.orderLabel.snp.right)
                make.top.equalToSuperview().offset(5)
            }

            // 计算歌名长度， 但不超过最大值，超过部分用省略号代替
            let max_songNameLen = Float(viewWidth * 0.6 - 100)
            var songNameLen: Float = 0
            let rect = getStrBoundRect(str: songName.text!, font: self.songName.font, constrainedSize: CGSize(width: self.songName.frame.size.width, height: 20))
            songNameLen = Float((songNameLen > max_songNameLen) ? max_songNameLen : Float(rect.width))
            self.songName.snp.makeConstraints { (make) in
                make.width.equalTo(songNameLen)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview()
            }

            // 计算歌手名字长度，但不超过最大值，超过部分用省略号代替
            let max_singerLen = Float(100)
            var singerLen: Float = 0
            let singerRect = getStrBoundRect(str: author.text!, font: self.author.font, constrainedSize: CGSize(width: self.author.frame.size.width, height: 20))
            singerLen = Float((singerLen > max_singerLen) ? max_singerLen : Float(singerRect.width))
            self.author.snp.makeConstraints { (make) in
                make.width.equalTo(singerLen)
                make.centerY.equalToSuperview()
                make.left.equalTo(self.songName.snp.right)
            }

            // 设置 trailText 的约束
            self.trailText.snp.makeConstraints { (make) in
                make.height.equalTo(rowHeight - 10)
                make.width.equalTo(30)
                make.centerY.equalToSuperview()
                make.left.equalTo(self.midView.snp.right).offset(10)
            }

            // 带标题样式
        } else if self.style == RowStyle.SubTitleStyle {
            // Row height
            let rowHeight: Float = Float(self.frame.height)
            let rowWidth: Float = Float(viewWidth)

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
                make.width.equalTo(rowWidth - Float(self.albumCover.frame.size.width) - 30 - 40 - 20)
                make.left.equalTo(self.albumCover.snp.right).offset(5)
                make.top.equalToSuperview().offset(5)
            }

            // 计算歌名长度， 但不超过最大值，超过部分用省略号代替
            let max_songNameLen = Float(viewWidth * 0.6 - 100)
            var songNameLen: Float = 0
            let rect = getStrBoundRect(str: songName.text!, font: self.songName.font, constrainedSize: CGSize(width: self.songName.frame.size.width, height: 20))
            songNameLen = Float((Float(rect.width) > max_songNameLen) ? max_songNameLen : Float(rect.width))
            self.songName.snp.makeConstraints { (make) in
                make.width.equalTo(songNameLen)
                make.left.equalToSuperview().offset(5)
                make.top.equalToSuperview()
            }

            // 计算歌手名字长度，但不超过最大值，超过部分用省略号代替
            let max_singerLen = Float(100)
            var singerLen: Float = 0
            let singerRect = getStrBoundRect(str: author.text!, font: self.author.font, constrainedSize: CGSize(width: self.author.frame.size.width, height: 20))
            singerLen = Float((Float(singerRect.width) > max_singerLen) ? max_singerLen : Float(singerRect.width))
            self.author.snp.makeConstraints { (make) in
                make.width.equalTo(singerLen)
                make.left.equalTo(self.songName.snp.right)
                make.top.equalToSuperview()
            }

            // 计算专辑简介长度，但不超过最大值，超过部分用省略号代替
            let max_albumDetailLen = rowWidth - Float(self.albumCover.frame.size.width) - 30 - 40 - 20
            var albumDetailLen: Float = 0
            let detailRect = getStrBoundRect(str: songDetail.text!, font: self.songDetail.font, constrainedSize: CGSize(width: self.songDetail.frame.size.width, height: 20))
            albumDetailLen = Float((Float(detailRect.width) > max_albumDetailLen) ? max_albumDetailLen : Float(detailRect.width))
            self.songDetail.snp.makeConstraints { (make) in
                make.width.equalTo(albumDetailLen)
                make.left.equalToSuperview().offset(5)
                make.top.equalTo(self.songName.snp.bottom).offset(5)
            }

            // 设置 playButtom 的约束
            self.playButtom.snp.makeConstraints { (make) in
                make.height.equalTo(rowHeight * 0.6)
                make.width.equalTo(rowHeight * 0.6)
                make.centerY.equalToSuperview()
                make.left.equalTo(self.midView.snp.right)
            }
        }
    }
    
    /*
    * 获取字符串边框
    */
    private func getStrBoundRect(str:String,font:UIFont,constrainedSize:CGSize,
                             option:NSStringDrawingOptions = NSStringDrawingOptions.usesLineFragmentOrigin)->CGRect{
        let attr = [NSAttributedString.Key.font:font]
        let rect = str.boundingRect(with: constrainedSize, options: NSStringDrawingOptions.usesFontLeading, attributes:attr , context: nil)
        let bound: CGRect = CGRect(x: 0, y: 0, width: rect.width + 15, height: rect.height)
        return bound
    }
}

// MARK - Configuration
extension RowStyleView {
    
    private func ConfigUI(style: RowStyle) {
        
        // 默认样式
        if style == .NoneStyle {
            self.addSubview(albumCover)
            self.addSubview(orderLabel)
            
            midView.addSubview(songName)
            midView.addSubview(author)
            self.addSubview(midView)
            
            self.addSubview(trailText)
        } else if style == .SubTitleStyle {
            self.addSubview(albumCover)
            self.addSubview(playButtom)
            self.addSubview(midView)

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
//    private func updateUI(mImgUrl: String, mSongname: String, mAuthor: String, mSongDetail: String) -> Void {
//        let num:Int = Int.random(in: 0..<3)
//        let url = mockdata4[num]
//        self.albumCover.kf.setImage(with: URL(string: url), placeholder: nil, options: nil, completionHandler:  { ( result ) in
//
//        })
//    }
    
    public func setUpRowViewWithDefultStyle(image picUrl: String, order: Int, songName: String, singer: String, style: RowStyle, extra: String){
        self.albumCover.kf.setImage(with: URL(string: picUrl), placeholder: nil, options: nil, completionHandler:  { ( result ) in
            
        })
        
        self.orderLabel.text = String(order)
        self.songName.text = songName
        self.author.text = "- " + singer
        self.trailText.text = extra
        self.style = style
    }
    
    public func setUpRowViewWithSubTitleStyle(image picUrl: String, songName: String, singer: String, foreword: String, style: RowStyle, extra: String){
        self.songName.text = ""
        self.author.text = ""
        self.songDetail.text = ""
        self.albumCover.image = nil
        
        
        self.albumCover.kf.setImage(with: URL(string: picUrl), placeholder: nil, options: nil, completionHandler:  { ( result ) in
            
        })
        
        self.songName.text = songName
        self.author.text = "- " + singer
        self.songDetail.text = foreword
        self.style = style
    }
}
