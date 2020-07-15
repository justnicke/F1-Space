//
//  CommonConstructor.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct ConstructorGroup: Codable {
    let constructorData: ConstructorData
    
    enum CodingKeys: String, CodingKey {
        case constructorData = "MRData"
    }
}

struct ConstructorData: Codable {
    var constructorStandingsTable: ConstructorStandingsTable
    
    enum CodingKeys: String, CodingKey {
        case constructorStandingsTable = "StandingsTable"
    }
}

struct ConstructorStandingsTable: Codable {
    var constructorStandingsLists: [ConstructorStandingsLists]
    
    enum CodingKeys: String, CodingKey {
        case constructorStandingsLists = "StandingsLists"
    }
}

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
}
