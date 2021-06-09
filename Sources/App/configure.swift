import Vapor
import Fluent
import FluentMySQLDriver

public func configure(_ app: Application) throws {
    
    app.databases.use(.mysql(
       hostname: "localhost",
       username: "root",
       password: "shenfu1991",
       database: "vapor_database",
       tlsConfiguration: .forClient(certificateVerification: .none)
     ), as: .mysql)
     
     app.migrations.add(CreateAcronym())
//    
//    let vc = RootController()
//    vc.boot()
     
     app.logger.logLevel = .debug
     
     try app.autoMigrate().wait()

    try routes(app)
}
