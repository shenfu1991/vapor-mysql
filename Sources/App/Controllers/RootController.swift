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
        let (mysqlDB,pools) = getMySQL()
        defer {
            pools.shutdown()
        }
        try? mysqlDB.query("select * from shenfu") { row in
             let value1 = row.column("name")?.string ?? ""
             let value2 = row.column("score")?.double ?? 0
             debugPrint("\(value1),\(value2)")
         } onMetadata: { _ in
         }.wait()
         add1(mysqlDB)
         query(mysqlDB)
    }
    
    func query(_ mysqlDB: MySQLDatabase) {
       try? mysqlDB.query("select * from shenfu") { row in
            let value1 = row.column("name")?.string ?? ""
            let value2 = row.column("score")?.double ?? 0
            debugPrint("\(value1),\(value2)")
        } onMetadata: { _ in
        }.wait()
    }
//
//    func update(_ mysqlDB: MySQLDatabase) {
//        try? mysqlDB.query("delete from shenfu") { row in
//        } onMetadata: { res in
//            debugPrint(res)
//        }
//    }
//
//    func delete(_ mysqlDB: MySQLDatabase) {
//        try? mysqlDB.query("delete from shenfu where name = ? and score = ?",["陆小凤",99]) { row in
//        } onMetadata: { _ in
//        }
//    }
//
//    func add(_ mysqlDB: MySQLDatabase) {
//        try? mysqlDB.query("insert into shenfu VALUES (?,?)",["成吉思汗",60]) { row in
//        } onMetadata: { res in
//            debugPrint(res)
//        }.always({ res in
//            debugPrint(res)
//        })
//    }
//
    func add1(_ mysqlDB: MySQLDatabase) {
        try? mysqlDB.query("insert into shenfu VALUES (?,?)",["王重阳",69]) { row in
        } onMetadata: { _ in
        }.wait()
    }
}
