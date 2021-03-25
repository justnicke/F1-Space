//
//  HistoricalCurrenDriverResultStub.swift
//  Formula CenturyTests
//
//  Created by Nikita Sukachev on 23.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

//public class HistoricalCurrenDriverResultStub: HistoricalCurrentDriverResultConfigurable {
//    var items: [String : [[String : Int]]] = [:]
//    var driverID: String = ""
//    var raceCounter: Int = 0
//    var winCounter: Int = 0
//    var podiumCounter: Int = 0
//    var poleCounter: Int = 0
//    var bestFinishCounter: Int = 0
//    var bestGridCounter: Int = 0
//    var retireCounter: Int = 0
//    var fastestLapCounter: Int = 0
//    var filteredResults: [[ResultF1]] = [[]]
//
//    func getPolePosition(_ grid: String) {
//        if grid == "1" {
//            self.poleCounter += 1
//        }
//    }
//
//    func getFastestLap(_ rank: String) {
//        if rank == "1" {
//            self.fastestLapCounter += 1
//        }
//    }
//
//    func getRetire(_ positionText: String) {
//        if positionText == "R" {
//            self.retireCounter += 1
//        }
//    }
//
//    func getBestFinish(_ position: Int) {
//        if self.bestFinishCounter == 0 {
//            self.bestFinishCounter = position
//        } else if self.bestFinishCounter > position {
//            self.bestFinishCounter = position
//        }
//    }
//
//    func getBestGrid(_ grid: Int) {
//        if self.bestGridCounter == 0 {
//            self.bestGridCounter = grid
//        } else if grid != 0 && self.bestGridCounter > grid {
//            self.bestGridCounter = grid
//        }
//    }
//
//    func getCurrentAchievement(_ position: String) {
//        if position == "1" {
//            self.winCounter += 1
//            self.podiumCounter += 1
//        } else if position == "2" || position == "3" {
//            self.podiumCounter += 1
//        }
//    }
//
//    func getDataWith(driver results: [ResultF1]) {
//        if results.isEmpty {
//            let trueOrFalse = [true, false]
//            if trueOrFalse.contains(true) {
//                self.raceCounter += 1
//                self.filteredResults.append(results)
//            }
//        }
//    }
//}