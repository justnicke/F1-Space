//
//  CommonStanding.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct DriverGroup: Codable {
    let driverData: DriverData
    
    enum CodingKeys: String, CodingKey {
        case driverData = "MRData"
    }
}

struct DriverData: Codable {
    var driverStandingsTable: DriverStandingsTable
    
    enum CodingKeys: String, CodingKey {
        case driverStandingsTable = "StandingsTable"
    }
}

struct DriverStandingsTable: Codable {
    var driverStandingsLists: [DriverStandingsLists]
    
    enum CodingKeys: String, CodingKey {
        case driverStandingsLists = "StandingsLists"
    }
}
