//
//  HistoricalCellViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 13.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalCellViewModel {
    
    // MARK: - Public Properties
    
    var first:  String?
    var second: String?
    var third:  String?
    var fourth: String?
    var fifth:  String?
    var sixth:  String?
    
    // MARK: - Private Properties
    
    private var driverStanding: DriverStandings?
    private var constructorStandings: ConstructorStandings?
    
    // MARK: - Constructors
    
    init(driverStanding: DriverStandings?, category: String?) {
        self.driverStanding = driverStanding
        setup(category: category)
    }
    
    init(constructorStandings: ConstructorStandings?, category: String?) {
        self.constructorStandings = constructorStandings
        setup(category: category)
    }
    
    // MARK: Private Methods
    
    private func setup(category: String?) {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            first = driverStanding?.position
            second = driverStanding?.driver.familyName
            third = driverStanding?.team.first?.name
            fourth = driverStanding?.points
        } else {
            first = constructorStandings?.position
            second = constructorStandings?.constructor.name
            third = constructorStandings?.points
        }
    }
}

