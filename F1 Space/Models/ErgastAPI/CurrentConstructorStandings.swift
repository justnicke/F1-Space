//
//  CurrentConstructorStandings.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 29.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Auxiliary model for checking the constructor in the current season
struct CurrentConstructorStandings: Codable {
    let currentConstructorStandingsData: CurrentConstructorStandingsData
    
    enum CodingKeys: String, CodingKey {
        case currentConstructorStandingsData = "MRData"
    }
}

struct CurrentConstructorStandingsData: Codable {
    let currentConstructorStandingsTable: CurrentConstructorStandingsTable
    
    enum CodingKeys: String, CodingKey {
        case currentConstructorStandingsTable = "StandingsTable"
    }
}

struct CurrentConstructorStandingsTable: Codable {
    let season: String
    let currentConstructorStandingsLists: [CurrentConstructorStandingsLists]
    
    enum CodingKeys: String, CodingKey {
        case season
        case currentConstructorStandingsLists = "StandingsLists"
    }
}

struct CurrentConstructorStandingsLists: Codable {
    let season: String
    let constructorStandings: [ConstructorStandings]
    
    enum CodingKeys: String, CodingKey {
        case season
        case constructorStandings = "ConstructorStandings"
    }
}
