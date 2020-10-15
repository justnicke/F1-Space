//
//  HistoricalHeaderViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalHeaderViewModel {
    
    // MARK: - Public Properties
    
    var first:  String?
    var second: String?
    var third:  String?
    var fourth: String?
    var fifth:  String?
    var sixth:  String?
    
    // MARK: - Private Properties
    
    private var historicalStandingsHeader: HistoricalStandingsHeader?
    
    // MARK: - Constructors
    
    init(driverStandingsHeader: HistoricalStandingsHeader?, category: String?) {
        self.historicalStandingsHeader = driverStandingsHeader
        setup(category: category)
    }
    
    init(constructorStandingsHeader: HistoricalStandingsHeader?, category: String?) {
        self.historicalStandingsHeader = constructorStandingsHeader
        setup(category: category)
    }
    
    init(raceHeader: HistoricalStandingsHeader?, category: String?) {
        self.historicalStandingsHeader = raceHeader
        setup(category: category)
    }
    
    // MARK: Private Methods
    
    private func setup(category: String?) {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            first = historicalStandingsHeader?.firstHead
            second = historicalStandingsHeader?.secondHead
            third = historicalStandingsHeader?.thirdHead
            fourth = historicalStandingsHeader?.fourthHead
        } else if category?.lowercased() == HistoricalCategory.teams.rawValue {
            first = historicalStandingsHeader?.firstHead
            second = historicalStandingsHeader?.secondHead
            third = historicalStandingsHeader?.thirdHead
        } else {
            first = historicalStandingsHeader?.firstHead
            second = historicalStandingsHeader?.secondHead
            third = historicalStandingsHeader?.thirdHead
        }
    }
}
