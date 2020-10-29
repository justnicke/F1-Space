//
//  ConstructorDetail.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

//struct DriverDetail: Codable {
//    let detailData: DetailDriverData
//
//    enum CodingKeys: String, CodingKey {
//        case detailData = "MRData"
//    }
//}

//struct DetailDriverData: Codable {
//    let detail: Detail
//
//    enum CodingKeys: String, CodingKey {
//        case detail = "RaceTable"
//    }
//}

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

// MARK: - RaceTable
struct ConstructorDetailTable: Codable {
    let races: [Race]

    enum CodingKeys: String, CodingKey {
        case races = "Races"
    }
}
