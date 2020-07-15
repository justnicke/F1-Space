//
//  CommonStanding.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct FormulaGroup: Codable {
    let mrData: MRData
    
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

struct MRData: Codable {
    var standingsTable: StandingsTable
    
    enum CodingKeys: String, CodingKey {
        case standingsTable = "StandingsTable"
    }
}

struct StandingsTable: Codable {
    var standingsLists: [StandingsLists]

    enum CodingKeys: String, CodingKey {
        case standingsLists = "StandingsLists"
    }
}
