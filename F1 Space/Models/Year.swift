//
//  Year.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct Year: Codable {
    let championship: Championship
    
    enum CodingKeys: String, CodingKey {
        case championship = "MRData"
    }
}

struct Championship: Codable {
    let yearsCount: String
    
    enum CodingKeys: String, CodingKey {
        case yearsCount = "total"
    }
}
