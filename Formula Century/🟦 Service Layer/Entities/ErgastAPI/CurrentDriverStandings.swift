//
//  CurrentDriverStandings.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Auxiliary model for checking the driver in the current season
struct CurrentDriverStandings: Codable {
    let currentDriverStandingsData: CurrentDriverStandingsData

    enum CodingKeys: String, CodingKey {
        case currentDriverStandingsData = "MRData"
    }
}

struct CurrentDriverStandingsData: Codable {
    let currentDriverStandingsTable: CurrentDriverStandingsTable

    enum CodingKeys: String, CodingKey {
        case currentDriverStandingsTable = "StandingsTable"
    }
}

struct CurrentDriverStandingsTable: Codable {
    let season: String
    let currentDriverStandingsLists: [CurrentDriverStandingsLists]

    enum CodingKeys: String, CodingKey {
        case season
        case currentDriverStandingsLists = "StandingsLists"
    }
}

struct CurrentDriverStandingsLists: Codable {
    let season: String
    let driverStandings: [DriverStandings]

    enum CodingKeys: String, CodingKey {
        case season
        case driverStandings = "DriverStandings"
    }
}
