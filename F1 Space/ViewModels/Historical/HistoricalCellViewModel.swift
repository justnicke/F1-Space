//
//  HistoricalCellViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 13.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalCellViewModel: HistoricalCellViewModelType {
    
    // MARK: - Public Properties
    
    var first:  String?
    var second: String?
    var third:  String?
    var fourth: String?
    var fifth:  String?
    var sixth:  String?
    
    // MARK: - Private Properties
    
    private(set) var driverStanding: DriverStandings?
    private(set) var constructorStandings: ConstructorStandings?
    private(set) var race: Race?
    private(set) var ditailedRace: Result?
    
    // MARK: - Constructors
    
    init(for driverStanding: DriverStandings?, by category: HistoricalCategory?, and id: String?) {
        self.driverStanding = driverStanding
        setup(by: category, and: id)
    }
    
    init(for constructorStandings: ConstructorStandings?, by category: HistoricalCategory?, and id: String?) {
        self.constructorStandings = constructorStandings
        setup(by: category, and: id)
    }
    
    /// The initializer is designed for the three data models
    /// - Parameter race: Designed for the driver, constructor and race winner model
    /// - Parameter category: Picker Selected - driver, constructor or races
    /// - Parameter id: Picker Selected  - "All" or "specific choice"
    init(for race: Race?, by category: HistoricalCategory?, and id: String?) {
        self.race = race
        setup(by: category, and: id)
    }
    
    init(for ditailedRace: Result?, by category: HistoricalCategory?, and id: String?) {
        self.ditailedRace = ditailedRace
        setup(by: category, and: id)
    }
    
    // MARK: Public Methods
    
    func setup(by category: HistoricalCategory?, and id: String?) {
        switch category {
        case .drivers:
            setupDriver(by: category, and: id)
        case .teams:
            setupConstructor(by: category, and: id)
        case .races:
            setupRaces(by: category, and: id)
        default: fatalError("This shouldn't happen at all! Func: \(#function)")
        }
    }
}
