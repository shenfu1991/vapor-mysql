import Vapor
import Fluent
import FluentMySQLDriver
import MySQLNIO

var kApp: Application!
public func configure(_ app: Application) throws {
    
    kApp = app
    
//    app.databases.use(.mysql(
//       hostname: "localhost",
//       username: "root",
//       password: "shenfu1991",
//       database: "vapor",
//        tlsConfiguration: .forClient(certificateVerification: .none)
//     ), as: .mysql)
//    try app.autoMigrate().wait()
   try? routes(app)

    let configuration = MySQLConfiguration(
        hostname: "localhost",
        port: 3306,
        username: "root",
        password: "shenfu1991",
        database: "vapor",
        tlsConfiguration: .forClient(certificateVerification: .none)
    )
    let eventLoopGroup: EventLoopGroup = app.eventLoopGroup.next()
//    defer { try? eventLoopGroup.syncShutdownGracefully() }

    let pools = EventLoopGroupConnectionPool(
        source: MySQLConnectionSource(configuration: configuration),
        on: eventLoopGroup
    )
    defer { pools.shutdown() }
//     app.migrations.add(CreateAcronym())

//     app.logger.logLevel = .debug
     
//    pools.withConnection(logger: Logger(label: "meng"), on: eventLoopGroup.next()) { cnn in
//
//    }
      
   let pool = pools.pool(for: eventLoopGroup.next())
    let mysql = pool.database(logger: Logger(label: "meng")) // MySQLDatabase
    let rows = try mysql.simpleQuery("SELECT @@version;").wait()
    debugPrint(rows)
    
    try? mysql.query("select * from shenfu") { row in
        let value1 = row.column("name")?.string ?? ""
        let value2 = row.column("score")?.double ?? 0
        debugPrint("\(value1),\(value2)")
    } onMetadata: { _ in
    }.wait()
   

    
//    DispatchQueue.global().asyncAfter(deadline: .now()+2) {
//        let vc = RootController()
//        vc.boot()
//    }
 
}
