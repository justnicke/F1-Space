//
//  Races.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 21.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

// Мне нужно: Название 1) гран при 2) победитель гонки, 3) конструктор

import Foundation

struct Crucit: Codable {
    let сrucitData: CrucitData
    
    enum CodingKeys: String, CodingKey {
        case сrucitData = "MRData"
    }
}

struct CrucitData: Codable {
    let grandPrix: GrandPrix
    
    enum CodingKeys: String, CodingKey {
        case grandPrix = "RaceTable"
    }
}

struct GrandPrix: Codable {
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
        case resultTime = "ResultTime"
        case finishStatus = "status"
    }
}

struct ResultTime: Codable {
    let time: String
}
