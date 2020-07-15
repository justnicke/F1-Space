//
//  Driver.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct StandingsLists: Codable {
    var driverStandings: [DriverStandings]

    enum CodingKeys: String, CodingKey {
        case driverStandings = "DriverStandings"
    }
}

struct DriverStandings: Codable {
    var position: String?
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

struct Driver: Codable {
    var givenName: String
    var familyName: String
}

struct Constructors: Codable {
    let name: String
}
