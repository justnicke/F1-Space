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
    private var race: Race?
    
    // MARK: - Constructors
    
    init(driverStanding: DriverStandings?, category: String?) {
        self.driverStanding = driverStanding
        setup(category: category)
    }
    
    init(constructorStandings: ConstructorStandings?, category: String?) {
        self.constructorStandings = constructorStandings
        setup(category: category)
    }
    
    init(race: Race?, category: String?) {
        self.race = race
        setup(category: category)
    }
    
    // MARK: Private Methods
    
    private func setup(category: String?) {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            first = driverStanding?.position
            second = driverStanding?.driver.familyName
            // if the driver changed teams during the year
            let constructors = driverStanding?.team.map { $0.name }
            third = constructors?.joined(separator: " / ")
            fourth = driverStanding?.points
        } else if category?.lowercased() == HistoricalCategory.teams.rawValue {
            first = constructorStandings?.position
            second = constructorStandings?.constructor.name
            third = constructorStandings?.points
        } else {
            first = race?.raceName
            second = race?.results.first?.driver.familyName
            third = race?.results.first?.constructor.name
        }
    }
}

