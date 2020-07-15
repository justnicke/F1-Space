//
//  Driver.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let mrData: MRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - MRData
struct MRData: Codable {
    var standingsTable: StandingsTable

    enum CodingKeys: String, CodingKey {
        case standingsTable = "StandingsTable"
    }
}

// MARK: - StandingsTable
struct StandingsTable: Codable {
    var standingsLists: [StandingsList]

    enum CodingKeys: String, CodingKey {
        case standingsLists = "StandingsLists"
    }
}

// MARK: - StandingsList
struct StandingsList: Codable {
    var driverStandings: [DriverStanding]

    enum CodingKeys: String, CodingKey {
        case driverStandings = "DriverStandings"
    }
}

// MARK: - DriverStanding
struct DriverStanding: Codable {
    let position: String?
    var points: String?
    var driver: Driver
    var constructors: [Constructors]
    
    enum CodingKeys: String, CodingKey {
        case position = "position"
        case points = "points"
        case driver = "Driver"
        case constructors = "Constructors"
    }
}

// MARK: - Driver
struct Driver: Codable {
    var givenName, familyName: String

    enum CodingKeys: String, CodingKey {
        case givenName, familyName
    }
}

// MARK: - Constructor
struct Constructors: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}
























struct StandingsTest {
    var drivers: [Drivers]
    var constructors: [Constructorz]
}

struct Drivers {
    let firstName: String?
    let lastName: String?
    let position: String?
    let pts: String?
    let team: String?
    let teamColor: UIColor?
}

struct Constructorz {
    let position: String?
    let pts: String?
    let team: String?
    let teamColor: UIColor?
}


