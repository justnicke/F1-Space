//
//  Constructor.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct ConstructorStandingsLists: Codable {
    var constructorStandings: [ConstructorStandings]
    
    enum CodingKeys: String, CodingKey {
        case constructorStandings = "ConstructorStandings"
    }
}

struct ConstructorStandings: Codable {
    var position: String?
    var points: String?
    var constructor: Constructor
    
    enum CodingKeys: String, CodingKey {
        case position = "position"
        case points = "points"
        case constructor =  "Constructor"
    }
}

struct Constructor: Codable {
    let name: String
    let constructorId: String
}
