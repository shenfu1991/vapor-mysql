//
//  File.swift
//  
//
//  Created by shenfu on 2021/6/9.
//

import Foundation
import Vapor
import MySQLNIO

class RootController {
    let db =  kApp.db  as! MySQLDatabase

    func boot() {
    debugPrint("boot")
     query()

    }
    
    func query() {
        db.query("select * from shenfu") { row in
            let value1 = row.column("name")?.string ?? ""
            let value2 = row.column("score")?.double ?? 0
            debugPrint("\(value1),\(value2)")
        } onMetadata: { _ in
        }
    }
    
    func update() {
        db.query("update shenfu set score = ? where name = ?",[90,"张无忌"]) { row in
        } onMetadata: { _ in
        }
    }
    
    func delete() {
        db.query("delete from shenfu where score = ?",[99]) { row in
        } onMetadata: { _ in
        }
    }
    
    func add() {
        db.query("insert into shenfu VALUES (?,?,?)",["8","陆小凤",99]) { row in
        } onMetadata: { _ in
        }
    }
}
