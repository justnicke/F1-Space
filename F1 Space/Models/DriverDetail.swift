//
//  DriverDetail.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 20.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct DriverDetail: Codable {
    let detailData: DetailDriverData

    enum CodingKeys: String, CodingKey {
        case detailData = "MRData"
    }
}

struct DetailDriverData: Codable {
    let detail: Detail

    enum CodingKeys: String, CodingKey {
        case detail = "RaceTable"
    }
}

struct Detail: Codable {
    let races: [Race]

    enum CodingKeys: String, CodingKey {
        case races = "Races"
    }
}
