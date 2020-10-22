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
    private var detailDriver: Race?
    
    // MARK: - Constructors
    
    init(driverStanding: DriverStandings?, category: String?, id: String?) {
        self.driverStanding = driverStanding
        setup(category: category, id: id)
    }
    
    init(constructorStandings: ConstructorStandings?, category: String?, id: String?) {
        self.constructorStandings = constructorStandings
        setup(category: category, id: id)
    }
    
    init(race: Race?, category: String?, id: String?) {
        self.race = race
        setup(category: category, id: id)
    }
    
    init(raceDetailDriver: Race?, category: String?, id: String?) {
        self.detailDriver = raceDetailDriver
        setup(category: category, id: id)
    }
    
    // MARK: Private Methods
    
    private func setup(category: String?, id: String?) {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
                first = driverStanding?.position
                second = driverStanding?.driver.familyName
                // if the driver changed teams during the year
                let constructors = driverStanding?.team.map { $0.name }
                third = constructors?.joined(separator: " / ")
                fourth = driverStanding?.points
            } else {
                first = detailDriver?.raceName.replacingOccurrences(of: "Grand Prix", with: "")
                second = detailDriver?.results.first?.position
                // Исправить тк круговые считаются сошедшими
                let checkFinished = detailDriver?.results.first?.finishStatus
                if checkFinished == "Finished" {
                    third = detailDriver?.results.first?.resultTime?.time
                } else {
                    third = "DNF"
                }
            
                fourth = detailDriver?.results.first?.points
            }
        } else if category?.lowercased() == HistoricalCategory.teams.rawValue {
            first = constructorStandings?.position
            second = constructorStandings?.constructor.name
            third = constructorStandings?.points
        } else {
            first = race?.raceName.replacingOccurrences(of: "Grand Prix", with: "")
            second = race?.results.first?.driver.familyName
            third = race?.results.first?.constructor.name
        }
    }
}

