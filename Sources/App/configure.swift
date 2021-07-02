import Vapor
import MySQLKit

var kApp: Application!

public func configure(_ app: Application) throws {
    
    kApp = app
    try? routes(app)
    
    let (mysqlDB,pools) = getMySQL()
    defer {
        pools.shutdown()
    }
    let rows = try mysqlDB.simpleQuery("SELECT @@version;").wait()
    debugPrint(rows)
    
    var arr: [String] = []
    
    try? mysqlDB.query("select * from shenfu") { row in
        let value1 = row.column("name")?.string ?? ""
        let value2 = row.column("score")?.double ?? 0
        debugPrint("\(value1),\(value2)")
        arr.append(value1)
    } onMetadata: { _ in
    }.wait()
    

    arr.forEach { name in
        try? mysqlDB.query("update shenfu set score = ? where name = ?",[99,MySQLData(string: name)]) { row in
            let value1 = row.column("name")?.string ?? ""
            let value2 = row.column("score")?.double ?? 0
            debugPrint("\(value1),\(value2)")
            arr.append(value1)
        } onMetadata: { _ in
        }.wait()
    }
    
   getIp()
}

let mana = NetwokingManager()
func getIp() {
    var url = "http://ip-api.com/json/"
    url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    mana.request(type: .ip, URLString: url , parameters: nil) { res in
//       debugPrint(res)
    } complete: { _ in
        DispatchQueue.global().asyncAfter(deadline: .now()+1, execute: {
            let vc = RootController()
            vc.boot()
        })
    }
}
