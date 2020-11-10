//
//  Season.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Championships held by year
struct Season: Codable {
    let championshipData: ChampionshipData
    
    enum CodingKeys: String, CodingKey {
        case championshipData = "MRData"
    }
}

struct ChampionshipData: Codable {
    let total: String

    enum CodingKeys: String, CodingKey {
        case total = "total"
    }
}
