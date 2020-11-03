//
//  Constructor.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct Constructor: Codable {
    let constructorID: String
    let url: String
    let name: String
    let nationality: String
    
    enum CodingKeys: String, CodingKey {
        case constructorID = "constructorId"
        case url
        case name
        case nationality
    }
}
