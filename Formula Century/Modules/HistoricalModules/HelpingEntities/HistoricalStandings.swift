//
//  HistoricalStandings.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct HistoricalStandings {
    
    // MARK: - Driver Standings
    
    var driverStandings: DriverStandings?
    
    init(_ driverStandings: DriverStandings) {
        self.driverStandings = driverStandings
    }
    
    // MARK: - Constructor Standings
    
    var constructorStandings: ConstructorStandings?
    
    init(_ constructorStandings: ConstructorStandings) {
        self.constructorStandings = constructorStandings
    }
}
