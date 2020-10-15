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
    let driver: Driver
    let constructor: Constructor
    
    enum CodingKeys: String, CodingKey {
        case driver = "Driver"
        case constructor = "Constructor"
    }
}

//// MARK: - Driver
//struct Driver: Codable {
//    let driverID, permanentNumber, code: String
//    let url: String
//    let givenName, familyName, dateOfBirth, nationality: String
//
//    enum CodingKeys: String, CodingKey {
//        case driverID = "driverId"
//        case permanentNumber, code, url, givenName, familyName, dateOfBirth, nationality
//    }
//}
