//
//  DriverParticipated.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 10.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/**
 Model for the driver who participated in the championship and the official number of years of the constructors Cup
 */
struct TwoOptions: Codable {
    let twoOptionsData: TwoOptionsData
    
    enum CodingKeys: String, CodingKey {
        case twoOptionsData = "MRData"
    }
}

struct TwoOptionsData: Codable {
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
