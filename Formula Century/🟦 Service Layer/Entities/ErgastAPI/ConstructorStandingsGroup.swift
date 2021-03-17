//
//  ConstructorStandingsGroup.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Gives the standings by constructor
struct ConstructorStandingsGroup: Codable {
    let constructorStandingsData: ConstructorStandingsData
    
    enum CodingKeys: String, CodingKey {
        case constructorStandingsData = "MRData"
    }
}

struct ConstructorStandingsData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit: String
    let offset: String
    let total: String
    let constructorStandingsTable: ConstructorStandingsTable
    
    enum CodingKeys: String, CodingKey {
        case xmlns
        case series
        case url
        case limit
        case offset
        case total
        case constructorStandingsTable = "StandingsTable"
    }
}

struct ConstructorStandingsTable: Codable {
    let season: String
    let constructorStandingsLists: [ConstructorStandingsLists]
    
    enum CodingKeys: String, CodingKey {
        case season
        case constructorStandingsLists = "StandingsLists"
    }
}

struct ConstructorStandingsLists: Codable {
    let season: String
    let round: String
    let constructorStandings: [ConstructorStandings]
    
    enum CodingKeys: String, CodingKey {
        case season
        case round
        case constructorStandings = "ConstructorStandings"
    }
}

struct ConstructorStandings: Codable {
    let position: String
    let positionText: String
    let points: String
    let wins: String
    let constructor: Constructor
    
    enum CodingKeys: String, CodingKey {
        case position
        case positionText
        case points
        case wins
        case constructor = "Constructor"
    }
}
