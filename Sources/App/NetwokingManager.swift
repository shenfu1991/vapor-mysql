//
//  NetwokingManager.swift
//  BTC-Core
//
//  Created by zhihong Meng on 2020/12/30.
//

import Vapor

enum RequestType {
    case currentPrice
    case kLine
    case order
    case push
    case balance
    case ip
    case historyOrder
    case getGlobalStatus
    case inStock
    case featureOrder
    case featureBalance
}

class NetwokingManager {
    
    var API_Key: String = ""
    
    typealias SuccessType = (_ result: Any?) -> Void
    typealias CompleteType = (Any) -> Void
    
//    init(with apiKey: String) {
//        self.API_Key = apiKey
//    }
    
      func request(type:RequestType,URLString:String,parameters: [String:Any]?, success: SuccessType?, complete: CompleteType?){
        let headers: HTTPHeaders = ["X-MBX-APIKEY": API_Key]

      if type == .ip {
            let res = kApp.client.get("\(URLString)",headers: headers).flatMapThrowing { res in
                try res.content.decode(IpModel.self)
            }.map { json in
                if let ss = success {
                    ss(json)
                }
            }
            res.whenComplete { (res) in
                if let com = complete {
                    com(res)
                }
            }
        }
        
    }
    
    
}
