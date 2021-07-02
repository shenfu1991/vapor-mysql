//
//  File.swift
//  
//
//  Created by shenfu on 2021/7/2.
//

import Vapor

struct IpModel: Content {
    var city: String?
    var timezone: String?
    var query: String?
}
