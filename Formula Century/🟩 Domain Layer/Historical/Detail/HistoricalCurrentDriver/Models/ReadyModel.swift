//
//  ReadyModel.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 25.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

struct CurrentDriver {
    let top:    Top
    let middle: Middle
    let bottom: Bottom
}

struct Top {
    let fullName:        String
    let nationality:     String
    let number:          String
    let dateBirth:       String
    let constructorName: String
    let season:          String
}

struct Middle {
    let driverItems: [String : [[String : Int]]]
}

struct Bottom {
    var race:       String
    var win:        String
    var podium:     String
    var pole:       String
    var bestFinish: String
    var bestGrid:   String
    var retire:     String
    var fastestLap: String
}
