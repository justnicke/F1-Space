//
//  CurrentConstructorStandings.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 29.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

// MARK: - Welcome
//struct CurrentConstructorStandings: Codable {
//    let currentConstructorStandingsData: CurrentConstructorStandingsData
//
//    enum CodingKeys: String, CodingKey {
//        case currentConstructorStandingsData = "MRData"
//    }
//}

// MARK: - MRData
//struct CurrentConstructorStandingsTable: Codable {
//    let currentConstructorStandingsTable: CurrentConstructorStandingsTable
//
//    enum CodingKeys: String, CodingKey {
//        case currentConstructorStandingsTable = "StandingsTable"
//    }
//}

// MARK: - StandingsTable
//struct CurrentConstructorStandingsTable: Codable {
//    let season: String
//    let currentConstructorStandingsLists: [CurrentDriverStandingsLists]
//
//    enum CodingKeys: String, CodingKey {
//        case season
//        case currentConstructorStandingsLists = "StandingsLists"
//    }
//}

// MARK: - StandingsList
//struct CurrentConstructorStandingsLists: Codable {
//    let season: String
//    let constructorStandings: [ConstructorStandings]
//
//    enum CodingKeys: String, CodingKey {
//        case season
//        case constructorStandings = "ConstructorStandings"
//    }
//}

// ------------------------------------------------------

// MARK: - Welcome
struct CurrentConstructorStandings: Codable {
    let currentConstructorStandingsData: CurrentConstructorStandingsData
    
    enum CodingKeys: String, CodingKey {
        case currentConstructorStandingsData = "MRData"
    }
}

// MARK: - MRData
struct CurrentConstructorStandingsData: Codable {
    let currentConstructorStandingsTable: CurrentConstructorStandingsTable
    
    enum CodingKeys: String, CodingKey {
        case currentConstructorStandingsTable = "StandingsTable"
    }
}

// MARK: - StandingsTable
struct CurrentConstructorStandingsTable: Codable {
    let season: String
    let currentConstructorStandingsLists: [CurrentConstructorStandingsLists]
    
    enum CodingKeys: String, CodingKey {
        case season
        case currentConstructorStandingsLists = "StandingsLists"
    }
}

// MARK: - StandingsList
struct CurrentConstructorStandingsLists: Codable {
    let season: String
    let constructorStandings: [ConstructorStandings]
    
    enum CodingKeys: String, CodingKey {
        case season
        case constructorStandings = "ConstructorStandings"
    }
}
