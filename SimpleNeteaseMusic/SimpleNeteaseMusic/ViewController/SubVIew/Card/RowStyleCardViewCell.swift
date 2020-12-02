//
//  RowStyleCardViewCell.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/12/2.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit


class RowView: UIView {
//    lazy var albumCoverView: UIView {
//
//    }
    
    // cover
    lazy var albumCover: UIImageView = {
        let cover = UIImageView()
        return cover
    }()
    
    // name
    lazy var songName: UILabel = {
        let name = UILabel()
        return name
    }()
    
    // author
    lazy var author: UILabel = {
        let author = UILabel()
        return author
    }()
    
    // desc
    lazy var songDetail: UILabel = {
        let songDetail = UILabel()
        return songDetail
    }()
    
    // paly buttom
    lazy var playButtom: UIButton  = {
        let btn = UIButton()
        return btn
    }()
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
    }
    
    func updateUI(mImgUrl: String, mSongname: String, mAuthor: String, mSongDetail: String) -> Void {
        
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
