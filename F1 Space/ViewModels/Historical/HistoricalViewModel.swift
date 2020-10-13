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
    private var driversStandings: [DriverStandings] = []
    private var construcorsStandings: [ConstructorStandings] = []
    
    // MARK: - Public Methods
    
    func selectedType(currentCategory: String?, yearStr: String?, compeletion: @escaping () -> (Void)) {
        if currentCategory?.lowercased() == HistoricalCategory.drivers.rawValue {
            requestDriverStandings(yearStr: yearStr, compeletion: compeletion)
        } else {
            requestConstructorStandings(yearStr: yearStr, compeletion: compeletion)
        }
    }
    
    // MARK: - Private Methods
    
    private func requestDriverStandings(yearStr: String?, compeletion: @escaping () -> (Void)) {
        guard let year = yearStr else { return }
        
        API.requestDriverStandings(year: year) { [weak self] (driver, err) in
            let drivers = driver?.driverData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
            guard let convertedDrivers = drivers?.reduce([], +) else { return }
            
            self?.driversStandings = convertedDrivers
            compeletion()
        }
    }
    
    private func requestConstructorStandings(yearStr: String?, compeletion: @escaping () -> (Void)) {
        guard let year = yearStr  else { return }
        
        API.requestConstructorStandings(year: year) { [weak self] (team, err) in
            let teams = team?.constructorData.constructorStandingsTable.constructorStandingsLists.compactMap { $0.constructorStandings }
            guard let convertedTeams = teams?.reduce([], +) else { return }
            
            self?.construcorsStandings = convertedTeams
            compeletion()
        }
    }
}

// MARK: - Extension HistoricalViewModelType

extension HistoricalViewModel: HistoricalViewModelType {
    func numberOfRows(inCurrent category: String?) -> Int {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            return driversStandings.count
        } else {
            return construcorsStandings.count
        }
    }
    
    func cellForRowAt(indexPath: IndexPath, inCurrent currentCategory: String?) -> HistoricalCellViewModel? {
        if currentCategory?.lowercased() == HistoricalCategory.drivers.rawValue {
            let driver = driversStandings[indexPath.row]
            return HistoricalCellViewModel(driverStanding: driver, category: currentCategory)
        } else {
            let constructor = construcorsStandings[indexPath.row]
            return HistoricalCellViewModel(constructorStandings: constructor, category: currentCategory)
        }
    }
}

