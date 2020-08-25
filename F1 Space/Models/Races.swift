//
//  Races.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 21.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Crucit: Codable {
    let mrData: MRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct MRData: Codable {
    let raceTable: GrandPrix

    enum CodingKeys: String, CodingKey {
        case raceTable = "RaceTable"
    }
}

// MARK: - RaceTable
struct GrandPrix: Codable {
    let races: [Race]

    enum CodingKeys: String, CodingKey {
        case races = "Races"
    }
}

// MARK: - Race
struct Race: Codable {
    let round: String
    let raceName: String
    
    enum CodingKeys: String, CodingKey {
        case raceName = "raceName"
        case round = "round"

    }
}
