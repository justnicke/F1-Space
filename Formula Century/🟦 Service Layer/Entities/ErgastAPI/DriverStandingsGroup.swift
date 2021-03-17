//
//  DriverStandingsGroup.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Gives the standings by driver
struct DriverStandingsGroup: Codable {
    let driverStandingsData: DriverStandingsData
    
    enum CodingKeys: String, CodingKey {
        case driverStandingsData = "MRData"
    }
}

struct DriverStandingsData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit: String
    let offset: String
    let total: String
    let driverStandingsTable: DriverStandingsTable
    
    enum CodingKeys: String, CodingKey {
        case xmlns
        case series
        case url
        case limit
        case offset
        case total
        case driverStandingsTable = "StandingsTable"
    }
}

struct DriverStandingsTable: Codable {
    let season: String
    let driverStandingsLists: [DriverStandingsLists]
    
    enum CodingKeys: String, CodingKey {
        case season
        case driverStandingsLists = "StandingsLists"
    }
}

struct DriverStandingsLists: Codable {
    let season: String
    let round: String
    let driverStandings: [DriverStandings]
    
    enum CodingKeys: String, CodingKey {
        case season
        case round
        case driverStandings = "DriverStandings"
    }
}

struct DriverStandings: Codable {
    let position: String
    let positionText: String
    let points: String
    let wins: String
    let driver: Driver
    let constructors: [Constructor]
    
    enum CodingKeys: String, CodingKey {
        case position
        case positionText
        case points
        case wins
        case driver = "Driver"
        case constructors = "Constructors"
    }
}
