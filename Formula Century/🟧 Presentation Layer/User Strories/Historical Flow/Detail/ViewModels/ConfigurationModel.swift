//
//  ConfigurationModel.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 19.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

final class ConfigurationModel {
    
    // MARK: - Private Properties
    
    private var items: [String : [[String : Int]]] = [:]
    private var results: [[ResultF1]]
    private var filteredResults = [[ResultF1]]()
    private var season: String
    private var driverID: String
    private var driverFullName: String
    private var nationality: String
    private var number: String
    private var dateOfBirth: String
    private var constructors: String
    private var raceCounter = 0
    private var winCounter = 0
    private var podiumCounter = 0
    private var poleCounter = 0
    private var bestFinishCounter = 0
    private var bestGridCounter = 0
    private var retireCounter = 0
    private var fastestLapCounter = 0
        
    // MARK: - Constructor
    
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
    private func configureComparison(_ result: [[ResultF1]]) {
        // вспомогательные свойствва и счетчики
        var supprots: [String] = []
        var teammate = ""

        // quali
        var driverQuali = 0
        var teammateQuali = 0
        // race
        var driverRace = 0
        var teammateRace = 0
        
        for (_, array) in result.enumerated() {
            for i in array {
                if i.driver.driverID != self.driverID {
                    supprots.append(i.driver.driverID)
                }
            }
        }
        
        let teammates = supprots.dropDuplicates()
        
        for (_, teammate) in teammates.enumerated() {
            if self.items.isEmpty {
                self.items["qualification"] = [[self.driverID : driverQuali, teammate: teammateQuali]]
                self.items["race"] = [[self.driverID : driverRace, teammate: teammateRace]]
            } else {
                self.items["qualification"]?.append([self.driverID : driverQuali, teammate: teammateQuali])
                self.items["race"]?.append([self.driverID : driverRace, teammate: teammateRace])
            }
        }
            
        for (_, array) in result.enumerated() {
            for i in array {
         
                if i.driver.driverID == self.driverID {
                    self.driverID = i.driver.driverID
                    driverQuali = Int(i.grid) ?? 0
                    driverRace = Int(i.position) ?? 0
                } else {
                    teammate = i.driver.driverID
                    teammateQuali = Int(i.grid) ?? 0
                    teammateRace = Int(i.position) ?? 0
                }
            }
            
            if driverQuali == teammateQuali {
                driverQuali = 0
                teammateQuali = 0
            } else if driverQuali < teammateQuali {
                driverQuali = 0
                teammateQuali = 0
                driverQuali += 1
            } else {
                teammateQuali = 0
                driverQuali = 0
                teammateQuali += 1
            }
                        
            if driverRace < teammateRace {
                driverRace = 0
                teammateRace = 0
                driverRace += 1
            } else {
                teammateRace = 0
                driverRace = 0
                teammateRace += 1
            }
            
            for (i,e) in self.items["qualification"]!.enumerated()  {
                if e.keys.contains(teammate) {
                    self.items["qualification"]?[i][self.driverID]! += driverQuali
                    self.items["qualification"]?[i][teammate]! += teammateQuali
                    
                    self.items["race"]?[i][self.driverID]! += driverRace
                    self.items["race"]?[i][teammate]! += teammateRace
                }
            }
        }
    }
}

protocol CheckingType {
    func getPolePosition(_ grid: String)
    func getFastestLap(_ rank: String)
    func getRetire(_ positionText: String)
    func getBestFinish(_ position: Int)
    func getBestGrid(_ grid: Int)
    func getCurrentAchievement(_ position: String)
    /// Get data with selected driver and teammate
    func getDataWith(driver results: [ResultF1])
}

extension ConfigurationModel: CheckingType {
    func getPolePosition(_ grid: String) {
        if grid == "1" {
            self.poleCounter += 1
        }
    }
    
    func getFastestLap(_ rank: String) {
        if rank == "1" {
            self.fastestLapCounter += 1
        }
    }
    
    func getRetire(_ positionText: String) {
        if positionText == "R" {
            self.retireCounter += 1
        }
    }
    
    func getBestFinish(_ position: Int) {
        if self.bestFinishCounter == 0 {
            self.bestFinishCounter = position
        } else if self.bestFinishCounter > position {
            self.bestFinishCounter = position
        }
    }
    
    func getBestGrid(_ grid: Int) {
        if self.bestGridCounter == 0 {
            self.bestGridCounter = grid
        } else if grid != 0 && self.bestGridCounter > grid {
            self.bestGridCounter = grid
        }
    }
    
    func getCurrentAchievement(_ position: String) {
        if position == "1" {
            self.winCounter += 1
            self.podiumCounter += 1
        } else if position == "2" || position == "3" {
            self.podiumCounter += 1
        }
    }
    
    func getDataWith(driver results: [ResultF1]) {
        let trueOrFalse = results.compactMap ({ $0.driver.driverID.contains(self.driverID) })
        if trueOrFalse.contains(true) {
            self.raceCounter += 1
            self.filteredResults.append(results)
        }
    }
}


