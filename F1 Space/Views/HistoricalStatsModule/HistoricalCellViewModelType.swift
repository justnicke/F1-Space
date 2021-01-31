//
//  HistoricalCellViewModelType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 17.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalCellViewModelType: class {
    var first:  String? { get set }
    var second: String? { get set }
    var third:  String? { get set }
    var fourth: String? { get set }
    var fifth:  String? { get set }
    var sixth:  String? { get set }
    
    var driverStanding: DriverStandings? { get }
    var constructorStandings: ConstructorStandings? { get }
    var race: Race? { get }
    var ditailedRace: ResultF1? { get }
}

// MARK: - Extension HistoricalCellViewModelType

extension HistoricalCellViewModelType {
    func setupDriver(by category: HistoricalCategory?, and id: String?) {
        if id.isAll() {
            first  = driverStanding?.position
            second = driverStanding?.driver.familyName
            third  = driverStanding?.constructors.map({ $0.name }).joined(separator: "\n")
            fourth = driverStanding?.points
        } else {
            first  = race?.raceName.replacingOccurrences(of: "Grand Prix", with: "")
            second = race?.results.first?.position
            third  = finished(true)
            fourth = race?.results.first?.points
        }
    }
    
    func setupConstructor(by category: HistoricalCategory?, and id: String?) {
        switch id.isAll() {
        case true:
            first  = constructorStandings?.position
            second = constructorStandings?.constructor.name
            third  = constructorStandings?.points
        case false:
            first  = race?.raceName.replacingOccurrences(of: "Grand Prix", with: "")
            second = race?.results.compactMap({ $0.driver.familyName }).joined(separator: "\n")
            third  = race?.results.compactMap({ $0.position }).joined(separator: "\n")
            fourth = finishedInTheSameTeam()
            fifth  = race?.results.compactMap({ $0.points }).joined(separator: "\n")
        }
    }
    
    func setupRaces(by category: HistoricalCategory?, and id: String?) {
        switch id.isAll() {
        case true:
            first  = race?.raceName.replacingOccurrences(of: "Grand Prix", with: "")
            second = race?.results.first?.driver.familyName
            third  = race?.results.first?.constructor.name
        case false:
            first  = ditailedRace?.position
            second = ditailedRace?.driver.familyName
            third  = finished(false)
            fourth = ditailedRace?.points
        }
    }
}

// MARK: - Extension HistoricalCellViewModelType Helper

extension HistoricalCellViewModelType {
    
    /// Depending on how the driver finished the answer will be given
    ///
    /// - Parameter selected: "True" for the driver category. "False" for the races category.
    func finished(_ selected: Bool) -> String? {
        // TRUE
        let finishStatusForDriverCategory = race?.results.first?.finishStatus
        // FLASE
        let finishStatusForRacesCategory = ditailedRace?.finishStatus
        let time = ditailedRace?.resultTime?.time
        
        if selected ? finishStatusForDriverCategory == "Finished" : finishStatusForRacesCategory == "Finished" {
            return selected ? finishStatusForDriverCategory : time
        } else if selected ? finishStatusForDriverCategory.unwrap.contains("Lap") : finishStatusForRacesCategory.unwrap.contains("Lap") {
            return selected ? finishStatusForDriverCategory : finishStatusForRacesCategory
        } else {
            return "DNF"
        }
    }
    
    /// Depending on how the drivers the same team finished the answer will be given
    func finishedInTheSameTeam() -> String? {
        guard let checkFinished = race?.results.compactMap({ $0.finishStatus }) else { return "DNF" }
        guard let time = race?.results.compactMap({ $0.resultTime?.time }) else { return "DNF"}
        var statusDriversTheSameTeam = [String]()
        var pass = true
        
        for finished in checkFinished {
            if finished.contains("Finished") {
                if pass {
                    statusDriversTheSameTeam.append(contentsOf: time)
                    pass = false
                }
            } else if finished.contains("Lap") {
                statusDriversTheSameTeam.append(finished)
            } else {
                statusDriversTheSameTeam.append("DNF")
            }
        }
        return statusDriversTheSameTeam.joined(separator: "\n")
    }
}
