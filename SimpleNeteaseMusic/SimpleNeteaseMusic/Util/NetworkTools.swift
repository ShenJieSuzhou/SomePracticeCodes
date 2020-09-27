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

class NetworkTools {
    class func requestData(_ type: MethodType, URLString: String, parameters: [String : Any]?, finishedCallback: @escaping (_ result: Any) -> ()){
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        AF.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.value else {
                print(response.error)
                return
            }
            
            finishedCallback(result)
        }
        
        
    }
}
