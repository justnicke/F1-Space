//
//  DriverDetail.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 20.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Detailed information about a specific driver
struct DriverDetail: Codable {
    let driverDetailData: DriverDetailData

    enum CodingKeys: String, CodingKey {
        case driverDetailData = "MRData"
    }
}

struct DriverDetailData: Codable {
    let driverDetailTable: DriverDetailTable

    enum CodingKeys: String, CodingKey {
        case driverDetailTable = "RaceTable"
    }
}

struct DriverDetailTable: Codable {
    let races: [Race]

    enum CodingKeys: String, CodingKey {
        case races = "Races"
    }
}
