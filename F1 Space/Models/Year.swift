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
    let standingsTable: StandingsTable
    enum CodingKeys: String, CodingKey {
        case yearsCount = "total"
        case standingsTable = "StandingsTable"
    }
}


//// MARK: - Welcome
//struct Welcome: Codable {
//    let mrData: MRData
//
//    enum CodingKeys: String, CodingKey {
//        case mrData = "MRData"
//    }
//}
//
//// MARK: - MRData
//struct MRData: Codable {
//    let xmlns: String
//    let series: String
//    let url: String
//    let limit, offset, total: String
//    let standingsTable: StandingsTable
//
//    enum CodingKeys: String, CodingKey {
//        case xmlns, series, url, limit, offset, total
//        case standingsTable = "StandingsTable"
//    }
//}

// MARK: - StandingsTable
struct StandingsTable: Codable {
    let driverID: String

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
    }
}
