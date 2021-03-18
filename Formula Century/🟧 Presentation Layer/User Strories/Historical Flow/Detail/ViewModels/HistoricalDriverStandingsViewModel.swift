//
//  HistoricalDriverStandingsViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 02.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalDriverStandingsViewModel: HistoricalDetailViewModelVariety {
    var driverID: String?
    var constructorsID: [String]?
    var season: String
    
    init(someValue: String, constructorsID: [String], season: String) {
        self.driverID = someValue
        self.constructorsID = constructorsID
        self.season = season
    }
    
//    init() { }
}
