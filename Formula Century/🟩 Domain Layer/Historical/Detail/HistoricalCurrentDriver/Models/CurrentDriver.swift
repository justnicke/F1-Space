//
//  CurrentDriver.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 25.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

struct CurrentDriver {
    let titile:      CurrentDriverTitle
    let comparison:  CurrentDriverComparison
    let description: CurrentDriverDescription
}

struct CurrentDriverTitle {
    let fullName:        String
    let nationality:     String
    let number:          String
    let dateBirth:       String
    let constructorName: String
    let season:          String
}

struct CurrentDriverComparison {
    let driverItems: [String : [[String : Int]]]
}

struct CurrentDriverDescription {
    let race:       String
    let win:        String
    let podium:     String
    let pole:       String
    let bestFinish: String
    let bestGrid:   String
    let retire:     String
    let fastestLap: String
}
