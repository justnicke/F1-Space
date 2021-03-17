//
//  ConstructorParticipated.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 10.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// A specific constructor participated in the championship by year
struct ConstructorParticipated: Codable {
    let constructorParticipatedData: ConstructorParticipatedData
    
    enum CodingKeys: String, CodingKey {
        case constructorParticipatedData = "MRData"
    }
}

struct ConstructorParticipatedData: Codable {
    let total: String
    let constructorParticipatedTable: ConstructorParticipatedTable
    
    enum CodingKeys: String, CodingKey {
        case total
        case constructorParticipatedTable = "StandingsTable"
    }
}

struct ConstructorParticipatedTable: Codable {
    let constructorParticipatedList: [ConstructorParticipatedList]
    
    enum CodingKeys: String, CodingKey {
        case constructorParticipatedList = "StandingsLists"
    }
}

struct ConstructorParticipatedList: Codable {
    let season: String
    
    enum CodingKeys: String, CodingKey {
        case season
    }
}
