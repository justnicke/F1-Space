//
//  Driver.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct DriverStandingsLists: Codable {
    var driverStandings: [DriverStandings]
    
    enum CodingKeys: String, CodingKey {
        case driverStandings = "DriverStandings"
    }
}

struct DriverStandings: Codable {
    var position: String?
    var points: String?
    var driver: Driver
    var team: [Team]
    
    enum CodingKeys: String, CodingKey {
        case position = "position"
        case points = "points"
        case driver = "Driver"
        case team = "Constructors"
    }
}

struct Driver: Codable {
    var driverID: String
    var givenName: String
    var familyName: String
    var nationality: String
    
    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case givenName = "givenName"
        case familyName = "familyName"
        case nationality = "nationality"
    }
}

struct Team: Codable {
    let name: String
}

