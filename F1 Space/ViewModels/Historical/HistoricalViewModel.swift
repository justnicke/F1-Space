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
    private var racesDetailConstructorHeader = HistoricalStandingsHeader("Grand Prix", "Drivers", "POS", "Time", "Points")
    private var racesDetailHeader = HistoricalStandingsHeader("POS", "Drivers", "Time", "Points")
    
    private var driversStandings: [DriverStandings] = []
    private var construcorsStandings: [ConstructorStandings] = []
    private var races: [Race] = []
    private var racesDetailDriver: [Race] = []
    private var racesDetailConstructors: [Race] = []
    private var racesDetail: [Result] = []
    
    private let year: String?
    private let category: String?
    private var id: String?
    
    // MARK: - Constructors
    
    init(year: String?, category: String?, id: String?) {

        self.year = year
        self.category = category
        self.id = id

        testRequest(year: self.year, id: self.id) { (str) -> (Void) in
//            print(str)
        }


//        print(self.year, self.category, self.id)
    }
    
    func testRequest(year: String?, id: String?, callback: @escaping (String?) -> (Void)) {
        guard let year = year,
              let crucitId = id
        else {
            return
        }
        API.requestConcreteRaceResults(year: year, roundId: crucitId) { [weak self] (crucit, err) in
            let aa = crucit?.racesDetailData.racesDetaiTable.races.first?.round
//            print(aa)
            if aa != nil{
                callback(id)
            } else {
                callback("All")
            }
        }
    }
    
    // MARK: - Public Methods
    
    func request(current category: String?, inThat year: String?, id: String?, compeletion: @escaping () -> (Void),
                                                                               callback: @escaping (String) -> (Void)) {
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
            testRequest(year: year, id: id) { [weak self] (identity) in
//                print(identity)
//                print(id)
                if identity == "All" {
                    self?.requestRaces(season: year, completion: compeletion)
                } else {
                    self?.requestRacesDetail(season: year, id: identity, completion: compeletion, callback: callback)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func requestRacesDetail(season: String?, id: String?, completion: @escaping () -> (Void),
                                                                  callback: @escaping (String) -> (Void)) {
        guard let year = season,
              let crucitId = id
        else {
            return
        }
        
        API.requestConcreteRaceResults(year: year, roundId: crucitId) {  [weak self] (races, err) in
            guard let racesDetail = races?.racesDetailData.racesDetaiTable.races.compactMap({ $0.results }) else { return }
            let result = racesDetail.reduce([], +)
            
            if !result.isEmpty {
                self?.racesDetail = result
                completion()
            } else {
                callback("All")
            }
        }
    }
    
    private func requestConstructorDetail(season: String?, id: String?, completion: @escaping () -> (Void)) {
        guard let year = season,
              let constructorId = id
        else {
            return
        }
        
        API.requestConstructorDetailResult(year: year, id: constructorId) { [weak self] (teamDetail, err) in
            guard let detailTeamRaces = teamDetail?.constructorDetailData.constructorDetailTable.races else { return }

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
            guard let detailRaces = detail?.driverDetailData.driverDetailTable.races else { return }
            
                self?.racesDetailDriver = detailRaces
                completion()
        }
    }
    
    private func requestDriverStandings(season: String?, compeletion: @escaping () -> (Void)) {
        guard let year = season else { return }
        
        API.requestDriverStandings(year: year) { [weak self] (driver, err) in
            let drivers = driver?.driverStandingsData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
            guard let convertedDrivers = drivers?.reduce([], +) else { return }
            
            self?.driversStandings = convertedDrivers
            compeletion()
        }
    }
    
    private func requestConstructorStandings(season: String?, compeletion: @escaping () -> (Void)) {
        guard let year = season  else { return }
        
        API.requestConstructorStandings(year: year) { [weak self] (team, err) in
            let teams = team?.constructorStandingsData.constructorStandingsTable.constructorStandingsLists.compactMap { $0.constructorStandings }
            guard let convertedTeams = teams?.reduce([], +) else { return }
            
            self?.construcorsStandings = convertedTeams
            compeletion()
        }
    }
    
    private func requestRaces(season: String?, completion: @escaping () -> (Void)) {
        guard let year = season  else { return }
        
        API.requestFirstPlaceResultInSeason(year: year) { [weak self] (gp, err) in
            guard let grandPrix = gp?.raceResultData.raceResultTable.races else { return }
//            print(grandPrix)
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
            if id == "All" {
                return races.count
            } else {
                return racesDetail.count
            }
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
            if id == "All" {
                let race = races[indexPath.row]
                return HistoricalCellViewModel(race: race, category: currentCategory, id: id)
            } else {
                let raceDetail = racesDetail[indexPath.row]
                return HistoricalCellViewModel(raceDetail: raceDetail, category: currentCategory, id: id)
            }
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
            if id == "All" {
                return HistoricalHeaderViewModel(constructorStandingsHeader: constructorsHeader, category: currentCategory, id: id)
            } else {
                return HistoricalHeaderViewModel(racesDetailConstructorHeader: racesDetailConstructorHeader, category: currentCategory, id: id)
            }
        } else {
            if id == "All" {
                return HistoricalHeaderViewModel(raceHeader: raceHeader, category: currentCategory, id: id)
            } else {
                return HistoricalHeaderViewModel(racesDetailHeader: racesDetailHeader, category: currentCategory, id: id)
            }
        }
    }
}


