//
//  HistoricalViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/*
 Внедряем данные для трасс: https://ergast.com/api/f1/2020/results/1
 //        guard let year = yearButton.titleLabel?.text  else { return }
 //        guard var standings = standingsButton.titleLabel?.text  else { return }
 //        guard let result = variantResultButton.titleLabel?.text else { return }
 //        guard let currentID = nameId else { return }
 if standings == "Teams" {
    standings = "constructors"
    if result == "All" {
        print("https://ergast.com/api/f1/\(year)/constructorStandings.json")
 } else {
    print("https://ergast.com/api/f1/\(year)/\(standings)/\(currentID)/results.json?limit=60")
 }
 } else if standings == "Drivers" {
    if result == "All" {
    print("https://ergast.com/api/f1/\(year)/driverStandings.json")
 } else {
    print("https://ergast.com/api/f1/\(year)/\(standings)/\(currentID)/results.json")
 }
 } else {
    if result == "All" {
 print("https://ergast.com/api/f1/\(year)/results/1.json")
 } else {
 // Делаем только резулятат гонки и квалификации, после UI разберемся
 print("https://ergast.com/api/f1/\(year)/\(currentID)/results.json") // трасса, победитель, команда
 }
 }
 */

final class HistoricalViewModel {
    
    // MARK: - Private Properties
    
    private var driversHeader = HistoricalStandingsHeader("POS", "Driver", "Constructor", "Points")
    private var constructorsHeader = HistoricalStandingsHeader("POS", "Constructor", "Points")
    private var raceHeader = HistoricalStandingsHeader("Grand Prix", "Winner", "Car")
    
    private var driversStandings: [DriverStandings] = []
    private var construcorsStandings: [ConstructorStandings] = []
    private var races: [Race] = []
    private var racesDetailDriver: [Race] = []
    
    // попробывать передать id в свойтсво и с ним поиграться и делать условия через него
    private var idenity: String?
    
    
    // MARK: - Public Methods
    
    func request(current category: String?, inThat year: String?, id: String?, compeletion: @escaping () -> (Void)) {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
                requestDriverStandings(season: year, compeletion: compeletion)
            } else {
                requestDriverDetail(season: year, id: id, completion: compeletion)
            }
        } else if category?.lowercased() == HistoricalCategory.teams.rawValue {
            requestConstructorStandings(season: year, compeletion: compeletion)
        } else {
            requestRaces(season: year, completion: compeletion)
        }
    }
    
    // MARK: - Private Methods
    
    private func requestDriverDetail(season: String?, id: String?, completion: @escaping () -> (Void)) {
        guard let year = season,
              let driverId = id
        else {
            return
        }

        API.requestDriverDetailResult(year: year, id: driverId) { [weak self] (detail, err) in
            let detailRaces = detail?.detailData.detail.races //else { return }
            
            if detailRaces!.isEmpty || detailRaces == nil {
                
            } else {
                self?.racesDetailDriver = detailRaces ?? []
                completion()
            }
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
        } else if category?.lowercased() == HistoricalCategory.teams.rawValue  {
            return construcorsStandings.count
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
            let constructor = construcorsStandings[indexPath.row]
            return HistoricalCellViewModel(constructorStandings: constructor, category: currentCategory, id: id)
        } else {
            let race = races[indexPath.row]
            return HistoricalCellViewModel(race: race, category: currentCategory, id: id)
        }
    }
    
    func viewForHeader(in section: Int, currentCategory: String?) -> HistoricalHeaderViewModel? {
        if currentCategory?.lowercased() == HistoricalCategory.drivers.rawValue {
            return HistoricalHeaderViewModel(driverStandingsHeader: driversHeader, category: currentCategory)
        } else if currentCategory?.lowercased() == HistoricalCategory.teams.rawValue {
            return HistoricalHeaderViewModel(constructorStandingsHeader: constructorsHeader, category: currentCategory)
        } else {
            return HistoricalHeaderViewModel(raceHeader: raceHeader, category: currentCategory)
        }
    }
}


