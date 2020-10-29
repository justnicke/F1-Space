//
//  HistoricalViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalViewModel {
    
    // MARK: - Private Properties
    
    private var driversHeader = HistoricalStandingsHeader("POS", "Driver", "Constructor", "Points")
    private var constructorsHeader = HistoricalStandingsHeader("POS", "Constructor", "Points")
    private var raceHeader = HistoricalStandingsHeader("Grand Prix", "Winner", "Car")
    private var racesDetailDriverHeader = HistoricalStandingsHeader("Grand Prix", "POS", "Time", "Points")
    
    private var driversStandings: [DriverStandings] = []
    private var construcorsStandings: [ConstructorStandings] = []
    private var races: [Race] = []
    private var racesDetailDriver: [Race] = []
    private var racesDetailConstructors: [Race] = []
    
    // MARK: - Public Methods
    
    func request(current category: String?, inThat year: String?, id: String?, compeletion: @escaping () -> (Void)) {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
                requestDriverStandings(season: year, compeletion: compeletion)
            } else {
                requestDriverDetail(season: year, id: id, completion: compeletion)
            }
        } else if category?.lowercased() == HistoricalCategory.teams.rawValue {
            if id == "All" {
                requestConstructorStandings(season: year, compeletion: compeletion)
            } else {
                requestConstructorDetail(season: year, id: id, completion: compeletion)
            }
        } else {
            requestRaces(season: year, completion: compeletion)
        }
    }
    
    // MARK: - Private Methods
    
    private func requestConstructorDetail(season: String?, id: String?, completion: @escaping () -> (Void)) {
        guard let year = season,
              let constructorId = id
        else {
            return
        }
        
        API.requestConstructorDetailResult(year: year, id: constructorId) { [weak self] (teamDetail, err) in
            guard let detailTeamRaces = teamDetail?.constructorDetailData.constructorDetailTable.races else { return }

//            var aa = detailTeamRaces.compactMap({ $0.results }).compactMap({ $0.compactMap ({$0.finishStatus})})
//            var array: [String] = []
//            var array2 = [[String]]()
//            for i in aa {
//                for str in i {
//                    if str.contains("Finished") {
//                        array.append(str)
//                    } else if str.contains("Lap") {
//                        array.append(str)
//                    } else {
//                        array.append("DNF")
//                    }
//                }
//                array2.append(array)
//                array.removeAll()
//            }
//            
//            print(array2)

            self?.racesDetailConstructors = detailTeamRaces
            completion()
        }
    }
    
    private func requestDriverDetail(season: String?, id: String?, completion: @escaping () -> (Void)) {
        guard let year = season,
              let driverId = id
        else {
            return
        }

        API.requestDriverDetailResult(year: year, id: driverId) { [weak self] (detail, err) in
            guard let detailRaces = detail?.detailData.detail.races else { return }

                self?.racesDetailDriver = detailRaces
                completion()
        }
    }
    
    private func requestDriverStandings(season: String?, compeletion: @escaping () -> (Void)) {
        guard let year = season else { return }
        
        API.requestDriverStandings(year: year) { [weak self] (driver, err) in
            let drivers = driver?.driverData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
            guard let convertedDrivers = drivers?.reduce([], +) else { return }
            
            self?.driversStandings = convertedDrivers
            compeletion()
        }
    }
    
    private func requestConstructorStandings(season: String?, compeletion: @escaping () -> (Void)) {
        guard let year = season  else { return }
        
        API.requestConstructorStandings(year: year) { [weak self] (team, err) in
            let teams = team?.constructorData.constructorStandingsTable.constructorStandingsLists.compactMap { $0.constructorStandings }
            guard let convertedTeams = teams?.reduce([], +) else { return }
            
            self?.construcorsStandings = convertedTeams
            compeletion()
        }
    }
    
    private func requestRaces(season: String?, completion: @escaping () -> (Void)) {
        guard let year = season  else { return }
        
        API.requestGrandPrix(year: year) { [weak self] (gp, err) in
            guard let grandPrix = gp?.сrucitData.grandPrix.races else { return }
            
            self?.races = grandPrix
            completion()
        }
    }
}

// MARK: - Extension HistoricalViewModelType

extension HistoricalViewModel: HistoricalViewModelType {
    func numberOfRows(inCurrent category: String?, id: String?) -> Int {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
            return driversStandings.count
            } else {
                return racesDetailDriver.count
            }
        } else if category?.lowercased() == HistoricalCategory.teams.rawValue {
            if id == "All" {
                return construcorsStandings.count
            } else {
                return racesDetailConstructors.count
            }
        } else {
            return races.count
        }
    }
    
    func cellForRowAt(indexPath: IndexPath, inCurrent currentCategory: String?, id: String?) -> HistoricalCellViewModel? {
        if currentCategory?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
                let driver = driversStandings[indexPath.row]
                return HistoricalCellViewModel(driverStanding: driver, category: currentCategory, id: id)
            } else {
                let detailDriver = racesDetailDriver[indexPath.row]
                return HistoricalCellViewModel(raceDetailDriver: detailDriver, category: currentCategory, id: id)
            }
        } else if currentCategory?.lowercased() == HistoricalCategory.teams.rawValue {
            if id == "All" {
                let constructor = construcorsStandings[indexPath.row]
                return HistoricalCellViewModel(constructorStandings: constructor, category: currentCategory, id: id)
            } else {
                let detailConstructor = racesDetailConstructors[indexPath.row]
                return HistoricalCellViewModel(raceDetailConstructor: detailConstructor, category: currentCategory, id: id)
            }
        } else {
            let race = races[indexPath.row]
            return HistoricalCellViewModel(race: race, category: currentCategory, id: id)
        }
    }
    
    func viewForHeader(in section: Int, currentCategory: String?, id: String?) -> HistoricalHeaderViewModel? {
        if currentCategory?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
                return HistoricalHeaderViewModel(driverStandingsHeader: driversHeader, category: currentCategory, id: id)
            } else {
                return HistoricalHeaderViewModel(raceDetailDriver: racesDetailDriverHeader, category: currentCategory, id: id)
            }
        } else if currentCategory?.lowercased() == HistoricalCategory.teams.rawValue {
            return HistoricalHeaderViewModel(constructorStandingsHeader: constructorsHeader, category: currentCategory, id: id)
        } else {
            return HistoricalHeaderViewModel(raceHeader: raceHeader, category: currentCategory, id: id)
        }
    }
}


