//
//  HistoricalCurrentDriverProperty.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 23.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalCurrentDriverProperty: AnyObject {
    var driverID: String { get set }
    var items: [String : [[String : Int]]] { get set}
}

protocol DriverStandingsResultCounterable: AnyObject {
    var raceCounter:       Int { get set }
    var winCounter:        Int { get set }
    var podiumCounter:     Int { get set }
    var poleCounter:       Int { get set }
    var bestFinishCounter: Int { get set }
    var bestGridCounter:   Int { get set }
    var retireCounter:     Int { get set }
    var fastestLapCounter: Int { get set }
    var filteredResults: [[ResultF1]] { get set }
}

protocol DriverStandingsItemsCounterable: AnyObject {
    var driverQualiCounter:   Int { get set }
    var teammateQualiCounter: Int { get set }
    var driverRaceCounter:    Int { get set }
    var teammateRaceCounter:  Int { get set }
    var teammate: String { get set }
}
