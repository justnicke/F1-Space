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
    private var detailContructor: Race?
    private var detailRace: Result?
    
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
    
    init(raceDetailConstructor: Race?, category: String?, id: String?) {
        self.detailContructor = raceDetailConstructor
        setup(category: category, id: id)
    }
    
    init(raceDetail: Result?, category: String?, id: String?) {
        self.detailRace = raceDetail
        setup(category: category, id: id)
    }
    
    // MARK: Private Methods
    
    private func setup(category: String?, id: String?) {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
                first = driverStanding?.position
                second = driverStanding?.driver.familyName
                // if the driver changed teams during the year
                let constructors = driverStanding?.constructors.map { $0.name }
                third = constructors?.joined(separator: "\n")
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
            if id == "All" {
                first = constructorStandings?.position
                second = constructorStandings?.constructor.name
                third = constructorStandings?.points
            } else {
                
                first = detailContructor?.raceName.replacingOccurrences(of: "Grand Prix", with: "")
                
                let secondLabel = detailContructor?.results.compactMap({ $0.driver.familyName }).joined(separator: "\n")
                
                second = secondLabel
                
                let thirdLabel = detailContructor?.results.compactMap({ $0.position }).joined(separator: "\n")
                third = thirdLabel
                
                let aaa = detailContructor?.results.compactMap({ $0.finishStatus })
                
                let time = detailContructor?.results.compactMap({$0.resultTime?.time})
                
                var array = [String]()
                var pass = true
                for str in aaa! {
                    
                    if str.contains("Finished") {
                        if pass {
                            array.append(contentsOf: time!)
                            pass = false
                        }
                    } else if str.contains("Lap") {
                        array.append(str)
                    } else {
                        array.append("DNF")
                    }
                }
                fourth = array.joined(separator: "\n")
                
                let fifthhLabel = detailContructor?.results.compactMap({ $0.points }).joined(separator: "\n")
                fifth = fifthhLabel
            }
        } else {
            if id == "All" {
                first = race?.raceName.replacingOccurrences(of: "Grand Prix", with: "")
                second = race?.results.first?.driver.familyName
                third = race?.results.first?.constructor.name
            } else {
                first = detailRace?.position
                second = detailRace?.driver.familyName
                
                guard let finishStatus = detailRace?.finishStatus else { return }
                let time = detailRace?.resultTime?.time
                
                if finishStatus.contains("Finished") {
                    third = time
                } else if finishStatus.contains("Lap") {
                    third = finishStatus
                } else {
                    third = "DNF"
                }
                
                fourth = detailRace?.points
                
            }
        }
    }
}
