import Vapor
import Fluent
import FluentMySQLDriver

var kApp: Application!
public func configure(_ app: Application) throws {
    
    kApp = app
    
    app.databases.use(.mysql(
       hostname: "localhost",
       username: "root",
       password: "shenfu1991",
       database: "vapor",
       tlsConfiguration: .forClient(certificateVerification: .none)
     ), as: .mysql)
     
     app.migrations.add(CreateAcronym())

//     app.logger.logLevel = .debug
     
     try app.autoMigrate().wait()

     try routes(app)
    
        let vc = RootController()
        vc.boot()
         
}
