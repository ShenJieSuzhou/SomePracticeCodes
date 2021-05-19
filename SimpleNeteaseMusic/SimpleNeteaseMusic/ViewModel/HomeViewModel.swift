//
//  HomeViewModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/14.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation
import Alamofire

// 协议回调

class HomeViewModel: NSObject {
    var sections = [HomeViewModelSection]()
    
    override init() {
        super.init()
        
    }
    
    // 获取首页数据，异步请求并将数据配置好
    func fetchData(url: String) {
        
        // 从配置文件中读取首页的数据并转换成数据模型
        do {
            if let bundlePath = Bundle.main.path(forResource: "mockdata", ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let homeData = try JSONDecoder().decode(HomePage.self, from: jsonData)
                
                // 拆分数据模型到各个板块
                sections = splitData(data: homeData.data.blocks)
                print(sections)
                
            } else {
                print("++++++++++++ 解析首页发现数据失败 ++++++++++++")
            }
        } catch let err {
            print(err)
        }
        
        // 请求数据 首页发现 + 圆形图片
//        AF.request(url, method: .get).responseDecodable { (response:DataResponse<HomePage, AFError>) in
//            guard let value = response.value else {
//                print(response.error ?? "Unknown error")
//                return
//            }
//        }
    }
    
    
    /// 拆分已解析好的数据到各个数据模型
    /// - Parameter data: 首页发现数据模型
    func splitData(data: [Block]) -> [HomeViewModelSection]{
        var array: [HomeViewModelSection] = [HomeViewModelSection]()
        
        for item in data {
            if item.blockCode == "HOMEPAGE_BANNER" || item.blockCode == "HOMEPAGE_MUSIC_MLOG"{
                switch item.extInfo {
                case .extInfoElementArray(let result):
                    // 精选音乐视频
                    let model: MusicMLOGModel = MusicMLOGModel(mLog: result, ui: item.uiElement!)
                    array.append(model)
                    break
                case .purpleEXTInfo(let result):
                    // BANNER
                    let banner: [Banner] = result.banners
                    let model: BannerModel = BannerModel(banners: banner)
                    array.append(model)
                    break
                case .none:
                    break
                }
            } else if item.blockCode == "HOMEPAGE_BLOCK_PLAYLIST_RCMD" {
                // 推荐歌单
                let ui: BlockUIElement = item.uiElement!
                let creatives: [Creative] = item.creatives!
                let model: PlaylistRcmdModel = PlaylistRcmdModel(creatives: creatives, ui: ui)
                array.append(model)
            } else if item.blockCode == "HOMEPAGE_BLOCK_STYLE_RCMD" {
                // 个性推荐
                let ui: BlockUIElement = item.uiElement!
                let creatives: [Creative] = item.creatives!
                let model:StyleRcmdModel = StyleRcmdModel(creatives: creatives, ui: ui)
                array.append(model)
            }  else if item.blockCode == "HOMEPAGE_BLOCK_MGC_PLAYLIST" {
                // 网易云音乐的雷达歌单
                let ui: BlockUIElement = item.uiElement!
                let creatives: [Creative] = item.creatives!
                let model:MgcPlaylistModel = MgcPlaylistModel(creatives: creatives, ui: ui)
                array.append(model)
            } else if item.blockCode == "HOMEPAGE_MUSIC_CALENDAR" {
                // 音乐日历
                let ui: BlockUIElement = item.uiElement!
                let creatives: [Creative] = item.creatives!
                let model:MusicCalendarModel = MusicCalendarModel(creatives: creatives, ui: ui)
                array.append(model)
            } else if item.blockCode == "HOMEPAGE_BLOCK_OFFICIAL_PLAYLIST" {
                // 专属场景歌单
                let ui: BlockUIElement = item.uiElement!
                let creatives: [Creative] = item.creatives!
                let model:OfficialPlaylistModel = OfficialPlaylistModel(creatives: creatives, ui: ui)
                array.append(model)
            } else if item.blockCode == "HOMEPAGE_BLOCK_NEW_ALBUM_NEW_SONG" {
                // 新歌
                let ui: BlockUIElement = item.uiElement!
                let creatives: [Creative] = item.creatives!
                let model: AlbumNewSongModel = AlbumNewSongModel(creatives: creatives, ui: ui)
                array.append(model)
            } else if item.blockCode == "HOMEPAGE_VOICELIST_RCMD" {
                // 播客合辑
                let ui: BlockUIElement = item.uiElement!
                let creatives: [Creative] = item.creatives!
                let model: VoiceListRcmdModel = VoiceListRcmdModel(creatives: creatives, ui: ui)
                array.append(model)
            } else if item.blockCode == "HOMEPAGE_PODCAST24" {
                // 24小时播客
                let ui: BlockUIElement = item.uiElement!
                let creatives: [Creative] = item.creatives!
                let model: Podcast24Model = Podcast24Model(creatives: creatives, ui: ui)
                array.append(model)
            } else if item.blockCode == "HOMEPAGE_BLOCK_VIDEO_PLAYLIST" {
                // 视频合辑
                let ui: BlockUIElement = item.uiElement!
                let creatives: [Creative] = item.creatives!
                let model: VideoPlaylistModel = VideoPlaylistModel(creatives: creatives, ui: ui)
                array.append(model)
            }
        }
        
        return array
    }
    
}
