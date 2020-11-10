//
//  RacesDetail.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 03.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Detailed information about a specific race
struct RaceDetail: Codable {
    let racesDetailData: RacesDetailData

    enum CodingKeys: String, CodingKey {
        case racesDetailData = "MRData"
    }
}

struct RacesDetailData: Codable {
    let racesDetaiTable: RacesDetaiTable

    enum CodingKeys: String, CodingKey {
        case racesDetaiTable = "RaceTable"
    }
}

struct RacesDetaiTable: Codable {
    let round: String
    let races: [Race]

    enum CodingKeys: String, CodingKey {
        case round
        case races = "Races"
    }
}



