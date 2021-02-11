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
    
    init(someValue: String, constructorsID: [String]) {
        self.driverID = someValue
        self.constructorsID = constructorsID
    }
    
    init() { }
}
