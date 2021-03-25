//
//  HistoricalCurrentDriverResultConfigurable.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 23.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalCurrentDriverResultConfigurable: DriverStandingsResultCounterable, HistoricalCurrentDriverProperty {
    func getPolePosition(_ grid: String)
    func getFastestLap(_ rank: String)
    func getRetire(_ positionText: String)
    func getBestFinish(_ position: Int)
    func getBestGrid(_ grid: Int)
    func getCurrentAchievement(_ position: String)
    /// Get data with selected driver and teammate
    func getDataWith(driver results: [ResultF1])
}

extension HistoricalCurrentDriverResultConfigurable {
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
            bestFinishCounter = position
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
