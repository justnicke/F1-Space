//
//  DriverParticipated.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 10.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// A specific driver participated in the championship by year
struct DriverParticipated: Codable {
    let driverParticipatedData: DriverParticipatedData
    
    enum CodingKeys: String, CodingKey {
        case driverParticipatedData = "MRData"
    }
}

struct DriverParticipatedData: Codable {
    let total: String
    let driverParticipatedTable: DriverParticipatedTable
    
    enum CodingKeys: String, CodingKey {
        case total
        case driverParticipatedTable = "StandingsTable"
    }
}

struct DriverParticipatedTable: Codable {
    let driverParticipatedList: [DriverParticipatedList]
    
    enum CodingKeys: String, CodingKey {
        case driverParticipatedList = "StandingsLists"
    }
}

struct DriverParticipatedList: Codable {
    let season: String
    
    enum CodingKeys: String, CodingKey {
        case season
    }
}
