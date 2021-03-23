//
//  DriverStandingsItemsConfigutable.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 23.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol DriverStandingsItemsConfigutable: DriverStandingsItemsCounterable, DriverStandingsProperty {
    func getTeammate(from results: [[ResultF1]]) -> [String]
    func addedValueForItems(from teammates: [String])
    func getValueCounters(from res: [ResultF1])
    func calculateQualifications()
    func calculateRaces()
    func reloadItems(_ items: EnumeratedSequence<[[String : Int]]>)
}

extension DriverStandingsItemsConfigutable {
    func getTeammate(from results: [[ResultF1]]) -> [String] {
        var teammates: [String] = []
        
        for res in results {
            for element in res {
                if element.driver.driverID != self.driverID {
                    teammates.append(element.driver.driverID)
                }
            }
        }
        return teammates
    }
    
    func addedValueForItems(from teammates: [String]) {
        for teammate in teammates {
            if self.items.isEmpty {
                self.items[AppKey.qualification.rawValue] = [[self.driverID : self.driverQualiCounter, teammate: self.teammateQualiCounter]]
                self.items[AppKey.race.rawValue] = [[self.driverID : self.driverRaceCounter, teammate: self.teammateRaceCounter]]
            } else {
                self.items[AppKey.qualification.rawValue]?.append([self.driverID : self.driverQualiCounter, teammate: self.teammateQualiCounter])
                self.items[AppKey.race.rawValue]?.append([self.driverID : self.driverRaceCounter, teammate: self.teammateRaceCounter])
            }
        }
    }
    
    func getValueCounters(from res: [ResultF1]) {
        for i in res {
            if i.driver.driverID == self.driverID {
                self.driverID = i.driver.driverID
                self.driverQualiCounter = Int(i.grid) ?? 0
                self.driverRaceCounter = Int(i.position) ?? 0
            } else {
                self.teammate = i.driver.driverID
                self.teammateQualiCounter = Int(i.grid) ?? 0
                self.teammateRaceCounter = Int(i.position) ?? 0
            }
        }
    }
    
    func calculateQualifications() {
        if driverQualiCounter == teammateQualiCounter {
            driverQualiCounter = 0
            teammateQualiCounter = 0
        } else if driverQualiCounter < teammateQualiCounter {
            driverQualiCounter = 0
            teammateQualiCounter = 0
            driverQualiCounter += 1
        } else {
            teammateQualiCounter = 0
            driverQualiCounter = 0
            teammateQualiCounter += 1
        }
    }
    
    func calculateRaces() {
        if driverRaceCounter < teammateRaceCounter {
            driverRaceCounter = 0
            teammateRaceCounter = 0
            driverRaceCounter += 1
        } else {
            teammateRaceCounter = 0
            driverRaceCounter = 0
            teammateRaceCounter += 1
        }
    }
    
    func reloadItems(_ items: EnumeratedSequence<[[String : Int]]>) {
        for (index, element) in items  {
            if element.keys.contains(teammate) {
                self.items[AppKey.qualification.rawValue]?[index][self.driverID]? += driverQualiCounter
                self.items[AppKey.qualification.rawValue]?[index][teammate]? += teammateQualiCounter
                
                self.items[AppKey.race.rawValue]?[index][self.driverID]? += driverRaceCounter
                self.items[AppKey.race.rawValue]?[index][teammate]? += teammateRaceCounter
            }
        }
    }
}
