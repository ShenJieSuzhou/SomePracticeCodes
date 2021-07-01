//
//  NetworkTools.swift
//  SimpleNeteaseMusic
//
//  Created by snaigame on 2020/9/28.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

enum NetworkError: Error {
    case invalidResponse
    case nilResponse
}

class NetworkManager<T: Codable> {
    // 网络请求
    static func requestData(_ type: MethodType,
                           URLString: String,
                           parameters: [String : Any]?,
                           completion: @escaping (Result<T, NetworkError>) -> Void) {

        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        AF.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.httpBody)
            .validate()
            .responseDecodable(of: T.self) { response in
                if let value = response.value {
                    completion(.success(value))
                    return
                }
                
                if let error = response.error {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.failure(.nilResponse))
        }
    }
}


