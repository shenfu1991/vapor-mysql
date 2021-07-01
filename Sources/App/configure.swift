import Vapor
import Fluent
import FluentMySQLDriver
import MySQLNIO

var kApp: Application!
var mysqlDB: MySQLDatabase!

public func configure(_ app: Application) throws {
    
    kApp = app
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
    let pool = pools.pool(for: eventLoopGroup.next())
    mysqlDB = pool.database(logger: Logger(label: "meng")) // MySQLDatabase
    let rows = try mysqlDB.simpleQuery("SELECT @@version;").wait()
    debugPrint(rows)
    
    try? mysqlDB.query("select * from shenfu") { row in
        let value1 = row.column("name")?.string ?? ""
        let value2 = row.column("score")?.double ?? 0
        debugPrint("\(value1),\(value2)")
    } onMetadata: { _ in
    }.wait()
   

    
        let vc = RootController()
        vc.boot()
  
 
}
