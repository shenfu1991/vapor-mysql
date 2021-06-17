import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    
    }
    
//    app.post("api","acronyms") {  req -> EventLoopFuture<Acronym> in
//        // 2
//         let acronym = try req.content.decode(Acronym.self)
//         // 3
//         return acronym.save(on: req.db).map { acronym }
//    }
    
//    app.get("api", "acronyms") {
//      req -> EventLoopFuture<[Acronym]> in
      // 2
//      Acronym.query(on: req.db).all()
//    }
    
//    func someHandler(_ req: Request) throws -> EventLoopFuture<[Acronym]> {
//        req.mysql.connection(to: .myDatabase) { conn in
//            SwifQL
//                .select(\SomeTable.$column1, \SomeTable.$column2)
//                .from(.table)
//                .execute(on: conn)
//                .all(decoding: Acronym.self)
//        }
//    }
}
