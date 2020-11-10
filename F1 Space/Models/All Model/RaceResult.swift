//
//  RaceResult.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 21.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct RaceResult: Codable {
    let raceResultData: RaceResultData
    
    enum CodingKeys: String, CodingKey {
        case raceResultData = "MRData"
    }
}

struct RaceResultData: Codable {
    let raceResultTable: RaceResultTable
    
    enum CodingKeys: String, CodingKey {
        case raceResultTable = "RaceTable"
    }
}

struct RaceResultTable: Codable {
    let races: [Race]
    
    enum CodingKeys: String, CodingKey {
        case races = "Races"
    }
}

struct Race: Codable {
    let round: String
    let raceName: String
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case raceName = "raceName"
        case round = "round"
        case results = "Results"
    }
}

struct Result: Codable {
    let position: String
    let points: String
    let driver: Driver
    let constructor: Constructor
    let resultTime: ResultTime?
    let finishStatus: String
    
    enum CodingKeys: String, CodingKey {
        case position = "position"
        case points = "points"
        case driver = "Driver"
        case constructor = "Constructor"
        case resultTime = "Time"
        case finishStatus = "status"
    }
}

struct ResultTime: Codable {
    let time: String
}
