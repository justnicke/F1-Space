//
//  HistoricalViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalViewModel {
    
    // MARK: - Private Properties
    
    private var driversHeader = HistoricalStandingsHeader("POS", "Driver", "Constructor", "Points")
    private var constructorsHeader = HistoricalStandingsHeader("POS", "Constructor", "Points")
    
    private var driversStandings: [DriverStandings] = []
    private var construcorsStandings: [ConstructorStandings] = []
}
