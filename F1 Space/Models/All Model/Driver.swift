//
//  Driver.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation



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

