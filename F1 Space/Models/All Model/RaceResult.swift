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
    let xmlns: String
    let series: String
    let url: String
    let limit: String
    let offset: String
    let total: String
    let raceResultTable: RaceResultTable
    
    enum CodingKeys: String, CodingKey {
        case xmlns
        case series
        case url
        case limit
        case offset
        case total
        case raceResultTable = "RaceTable"
    }
}

struct RaceResultTable: Codable {
    let season: String
    let position: String
    let races: [Race]
    
    enum CodingKeys: String, CodingKey {
        case season
        case position
        case races = "Races"
    }
}

struct Race: Codable {
    let season: String
    let round: String
    let url: String
    let raceName: String
    let circuit: Circuit
    let date: String
    let time: String
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case season
        case round
        case url
        case raceName
        case circuit = "Circuit"
        case date
        case time
        case results = "Results"
    }
}

struct Circuit: Codable {
    let circuitID: String
    let url: String
    let circuitName: String
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case circuitID = "circuitId"
        case url
        case circuitName
        case location = "Location"
    }
}

struct Location: Codable {
    let lat: String
    let long: String
    let locality: String
    let country: String
}

struct Result: Codable {
    let number: String
    let position: String
    let positionText: String
    let points: String
    let driver: Driver
    let constructor: Constructor
    let grid: String
    let laps: String
    let status: String
    let time: ResultTime
    
    enum CodingKeys: String, CodingKey {
        case number
        case position
        case positionText
        case points
        case driver = "Driver"
        case constructor = "Constructor"
        case grid
        case laps
        case status
        case time = "Time"
    }
}

struct ResultTime: Codable {
    let time: String
}
