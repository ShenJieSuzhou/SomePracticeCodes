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
        // 请求数据
        AF.request(url, method: .get).responseDecodable { (response:DataResponse<HomePage, AFError>) in
            guard let value = response.value else {
                print(response.error ?? "Unknown error")
                return
            }
        }
    }
}


//NetWorkTools.singleton.requestData(.get, URLString: url, parameters: nil) { result in
//    print(result)
//    if let homeModel = try? JSONDecoder().decode(HomePage.self, from: result) {
//        dump(homeModel)
//    }
//} error: { err in
//    print(err)
//}
