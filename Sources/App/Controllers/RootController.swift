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

    func boot() {
        debugPrint("boot")
        add()
        add1()
        DispatchQueue.global().asyncAfter(deadline: .now()+5) {
            self.update()
        }
        DispatchQueue.global().asyncAfter(deadline: .now()+7) {
            self.query()
        }
    }
    
    func query() {
       try? mysqlDB.query("select * from shenfu") { row in
            let value1 = row.column("name")?.string ?? ""
            let value2 = row.column("score")?.double ?? 0
            debugPrint("\(value1),\(value2)")
        } onMetadata: { _ in
        }.wait()
    }
    
    func update() {
        try? mysqlDB.query("update shenfu set score = ? where name = ?",[90,"张无忌"]) { row in
        } onMetadata: { _ in
        }.wait()
    }
    
    func delete() {
        try? mysqlDB.query("delete from shenfu where name = ?",["陆小凤"]) { row in
        } onMetadata: { _ in
        }.wait()
    }
    
    func add() {
        try? mysqlDB.query("insert into shenfu VALUES (?,?)",["陆小凤",99]) { row in
        } onMetadata: { _ in
        }.wait()
    }
    
    func add1() {
        try? mysqlDB.query("insert into shenfu VALUES (?,?)",["张无忌",199]) { row in
        } onMetadata: { _ in
        }.wait()
    }
}
