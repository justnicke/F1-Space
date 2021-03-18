//
//  Driver.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Info about the driver
struct Driver: Codable {
    let driverID: String
    let url: String
    let givenName: String
    let familyName: String
    let dateOfBirth: String
    let nationality: String
    var permanentNumber: String?

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case url
        case givenName
        case familyName
        case dateOfBirth
        case nationality
        case permanentNumber
    }
}

