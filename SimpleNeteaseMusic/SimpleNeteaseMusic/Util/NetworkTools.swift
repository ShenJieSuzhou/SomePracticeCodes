//
//  NetworkTools.swift
//  SimpleNeteaseMusic
//
//  Created by snaigame on 2020/9/28.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import Alamofire

typealias ReqResponseSuccess = (_ response: Data) -> Void
typealias ReqResponseFail = (_ error: Error) -> Void

enum MethodType {
    case get
    case post
}

class NetWorkTools {
    // 创建单例对象
    static let singleton = NetWorkTools()
    
    // 网络请求
//    public func requestData(_ type: MethodType,
//                           URLString: String,
//                           parameters: [String : Any]?,
//                           success: @escaping ReqResponseSuccess,
//                           error: @escaping ReqResponseFail,
//                           of: T.Type){
//
//        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
//        AF.request(URLString, method: method, parameters: parameters)
//            .validate()
//            .responseDecodable(of: T.self) { (response) in
//
//            }
            
//        request.responseDecodable(of: HomePage.self) { (data) in
//            guard let model = data.value else { return }
//            print(model)
//        }
//        request.responseJSON { (data) in
//            print(data)
////            success(data)
//        }
        
        
        
//        AF.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
//            print(response)
//            switch response.result{
//                case .success:
//                    if let value = response.data {
//                        print(value)
//                        success(value)
//                    }
//                    break
//                case .failure(let err):
//                    error(err)
//                    break
//            }
//        }
//    }
}
