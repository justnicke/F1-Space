//
//  ConstructorDetail.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Detailed information about a specific constructor
struct ConstructorDetail: Codable {
    let constructorDetailData: ConstructorDetailData
    
    enum CodingKeys: String, CodingKey {
        case constructorDetailData = "MRData"
    }
}

struct ConstructorDetailData: Codable {
    let constructorDetailTable: ConstructorDetailTable
    
    enum CodingKeys: String, CodingKey {
        case constructorDetailTable = "RaceTable"
    }
}

struct ConstructorDetailTable: Codable {
    let season: String
    let races: [Race]
    
    enum CodingKeys: String, CodingKey {
        case season = "season"
        case races = "Races"
    }
}
