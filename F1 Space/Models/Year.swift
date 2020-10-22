//
//  Year.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct Year: Codable {
    let championship: Championship
    
    enum CodingKeys: String, CodingKey {
        case championship = "MRData"
    }
}

struct Championship: Codable {
    let yearsCount: String

    enum CodingKeys: String, CodingKey {
        case yearsCount = "total"
    }
}


// MARK: - Driver

struct DriverTakePartYear: Codable {
    let takePartYear: TakePartYear

    enum CodingKeys: String, CodingKey {
        case takePartYear = "MRData"
    }
}

// MARK: - MRData
struct TakePartYear: Codable {
    let total: String
    let standingsTable: StandingsTable

    enum CodingKeys: String, CodingKey {
        case total
        case standingsTable = "StandingsTable"
    }
}

// MARK: - StandingsTable
struct StandingsTable: Codable {
//    let driverID: String
    let standingsLists: [StandingsList]
    
    enum CodingKeys: String, CodingKey {
//        case driverID = "driverId"
        case standingsLists = "StandingsLists"
    }
}

// MARK: - StandingsList
struct StandingsList: Codable {
    let season: String
    
    enum CodingKeys: String, CodingKey {
        case season
    }
}
