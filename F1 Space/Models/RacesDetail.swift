//
//  RacesDetail.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 03.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct RacesDetail: Codable {
    let racesDetailData: RacesDetailData

    enum CodingKeys: String, CodingKey {
        case racesDetailData = "MRData"
    }
}

// MARK: - MRData
struct RacesDetailData: Codable {
    let racesDetaiTable: RacesDetaiTable

    enum CodingKeys: String, CodingKey {
        case racesDetaiTable = "RaceTable"
    }
}

// MARK: - RaceTable
struct RacesDetaiTable: Codable {
//    let season, round: String
    let races: [Race]

    enum CodingKeys: String, CodingKey {
//        case season, round
        case races = "Races"
    }
}
