//
//  CommonConstructor.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct ConstructorGroup: Codable {
    let constructorData: ConstructorData
    
    enum CodingKeys: String, CodingKey {
        case constructorData = "MRData"
    }
}

struct ConstructorData: Codable {
    var constructorStandingsTable: ConstructorStandingsTable
    
    enum CodingKeys: String, CodingKey {
        case constructorStandingsTable = "StandingsTable"
    }
}

struct ConstructorStandingsTable: Codable {
    var constructorStandingsLists: [ConstructorStandingsLists]
    
    enum CodingKeys: String, CodingKey {
        case constructorStandingsLists = "StandingsLists"
    }
}

