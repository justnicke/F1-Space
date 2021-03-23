//
//  ConfigurationModel.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 19.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

final class ConfigurationModel: DriverStandingsConfiguratorType {
    
    // MARK: - Public Properties
    
    // MARK: - DriverStandingsResultCounterable
    
    var raceCounter       = 0
    var winCounter        = 0
    var podiumCounter     = 0
    var poleCounter       = 0
    var bestFinishCounter = 0
    var bestGridCounter   = 0
    var retireCounter     = 0
    var fastestLapCounter = 0
    var filteredResults = [[ResultF1]]()
    
    // MARK: - DriverStandingsItemsCounterable
    
    var driverQualiCounter   = 0
    var teammateQualiCounter = 0
    var driverRaceCounter    = 0
    var teammateRaceCounter  = 0
    var teammate = ""
    
    // MARK: - DriverStandingsProperty
    
    var driverID: String
    var items: [String : [[String : Int]]] = [:]
    
    // MARK: - Private Properties

    private var season: String
    private var driverFullName: String
    private var nationality: String
    private var number: String
    private var dateOfBirth: String
    private var constructors: String
    private var results: [[ResultF1]]
        
    // MARK: - Constructors
    
    init(results: [[ResultF1]], season: String, driverStandings: DriverStandings) {
        self.results        = results
        self.season         = season
        self.driverID       = driverStandings.driver.driverID
        self.driverFullName = driverStandings.driver.givenName + " " + driverStandings.driver.familyName
        self.nationality    = driverStandings.driver.nationality
        self.number         = driverStandings.driver.permanentNumber ?? ""
        self.dateOfBirth    = driverStandings.driver.dateOfBirth
        self.constructors   = driverStandings.constructors.map({ $0.name }).joined(separator: " / ")
        
        self.executeAlgorithm()
    }
    
    // MARK: - Public Methods
    
    func setup() -> ReadyModel {
        let top = Top(
            fullName:        self.driverFullName,
            nationality:     self.nationality,
            number:          self.number,
            dateBirth:       self.dateOfBirth,
            constructorName: self.constructors,
            season:          self.season
        )
        
        let middle = Middle(driverItems: self.items)
        
        let bottom = Bottom(
            race:       self.raceCounter.toString(),
            win:        self.winCounter.toString(),
            podium:     self.podiumCounter.toString(),
            pole:       self.poleCounter.toString(),
            bestFinish: self.bestFinishCounter.toString(),
            bestGrid:   self.bestGridCounter.toString(),
            retire:     self.retireCounter.toString(),
            fastestLap: self.fastestLapCounter.toString()
        )
        
        return ReadyModel(top: top, middle: middle, bottom: bottom)
    }
    
    // MARK: - Private Methods
    
    private func executeAlgorithm() {
        self.configureResult()
        self.configureComparison(self.filteredResults)
    }
    
    /// Getting the data where the selected driver is present
    private func configureResult() {
        for (_, res) in self.results.enumerated() {
            for element in res {
                if element.driver.driverID.contains(self.driverID) {
                    self.getCurrentAchievement(element.position)
                    self.getBestGrid(Int(element.grid) ?? 0)
                    self.getBestFinish(Int(element.position) ?? 0)
                    self.getPolePosition(element.grid)
                    self.getFastestLap(element.fastestLap?.rank ?? "unknown")
                    self.getRetire(element.positionText)
                }
            }
            self.getDataWith(driver: res)
        }
    }
    
    /// Dictionary configuration for comparing a driver with teammates
    private func configureComparison(_ results: [[ResultF1]]) {
        let teammates = self.getTeammate(from: results).dropDuplicates()
        
        self.addedValueForItems(from: teammates)
        
        for res in results {
            self.getValueCounters(from: res)
            self.calculateQualifications()
            self.calculateRaces()
            
            guard let items = self.items[AppKey.qualification.rawValue]?.enumerated() else {
                return
            }
            
            self.reloadItems(items)
        }
    }
}
