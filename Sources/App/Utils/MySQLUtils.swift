//
//  File.swift
//  
//
//  Created by shenfu on 2021/7/2.
//

import MySQLKit

func getMySQL() ->(MySQLDatabase,EventLoopGroupConnectionPool<MySQLConnectionSource>) {
    let configuration = MySQLConfiguration(
        hostname: "localhost",
        port: 3306,
        username: "root",
        password: "shenfu1991",
        database: "vapor",
        tlsConfiguration: .forClient(certificateVerification: .none)
    )
    let eventLoopGroup: EventLoopGroup = kApp.eventLoopGroup.next()
//    defer { try? eventLoopGroup.syncShutdownGracefully() }

    let pools = EventLoopGroupConnectionPool(
        source: MySQLConnectionSource(configuration: configuration),
        on: eventLoopGroup
    )
//    defer { pools.shutdown() }
    let pool = pools.pool(for: eventLoopGroup.next())
    return (pool.database(logger: Logger(label: "meng")),pools) // MySQLDatabase
}
