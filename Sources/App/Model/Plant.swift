//
//  File.swift
//  
//
//  Created by shenfu on 2021/6/10.
//

import Fluent
import Vapor

final class Planet: Model {
    // Name of the table or collection.
    static let schema = "planets"

    // Unique identifier for this Planet.
    @ID(key: .id)
    var id: UUID?

    // The Planet's name.
    @Field(key: "name")
    var name: String

    // Creates a new, empty Planet.
    init() { }

    // Creates a new Planet with all properties set.
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
