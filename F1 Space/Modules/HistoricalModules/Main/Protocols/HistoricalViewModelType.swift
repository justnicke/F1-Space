//
//  HistoricalViewModelType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 13.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Common interface ViewModel for properties, delegate, and dataSource
protocol HistoricalViewModelType:
    HistoricalViewModelProperty,
    HistoricalViewModelDelegate,
    HistoricalViewModelDataSource {}

// MARK: - Extension NumberOfRows

extension HistoricalViewModelType {
    func numberOfRowsDrivers() -> Int {
        switch id.isAll() {
        case true:  return take.driverStandings.count
        case false: return take.racesDetailDriver.count
        }
    }
    
    func numberOfRowsConstructors() -> Int {
        switch id.isAll() {
        case true:  return take.constructorStandings.count
        case false: return take.racesDetailConstructors.count
        }
    }
    
    func numberOfRowsRaces() -> Int {
        switch id.isAll() {
        case true:  return take.firstPlaceResultInRace.count
        case false: return take.racesDetail.count
        }
    }
}

// MARK: - Extension CellForRowAtIndexPath

extension HistoricalViewModelType {
    func cellForRowDriver(at indexPath: IndexPath) -> HistoricalCellViewModel? {
        switch id.isAll() {
        case true:  return HistoricalCellViewModel(for: take.driverStandings[indexPath.row], by: category, and: id)
        case false: return HistoricalCellViewModel(for: take.racesDetailDriver[indexPath.row], by: category, and: id)
        }
    }
    
    func cellForRowConstructor(at indexPath: IndexPath) -> HistoricalCellViewModel? {
        switch id.isAll() {
        case true:  return HistoricalCellViewModel(for: take.constructorStandings[indexPath.row], by: category, and: id)
        case false: return HistoricalCellViewModel(for: take.racesDetailConstructors[indexPath.row], by: category, and: id)
        }
    }
    
    func cellForRowRace(at indexPath: IndexPath) -> HistoricalCellViewModel? {
        switch id.isAll() {
        case true:  return HistoricalCellViewModel(for: take.firstPlaceResultInRace[indexPath.row], by: category, and: id)
        case false: return HistoricalCellViewModel(for: take.racesDetail[indexPath.row], by: category, and: id)
        }
    }
}

// MARK: - Extension DidSelectRowAtIndexPath

extension HistoricalViewModelType {
    func didSelectRowDriver(at indexPath: IndexPath) -> HistoricalDetailViewModelVariety {
        switch id.isAll() {
        case true:  return HistoricalDriverStandingsViewModel(someValue: take.driverStandings[indexPath.row].driver.driverID)
        case false: return HistoricalDriverDetailViewModel(someValue: take.racesDetailDriver[indexPath.row].raceName)
        }
    }
    
    func didSelectRowConstructor(at indexPath: IndexPath) -> HistoricalDetailViewModelVariety {
        switch id.isAll() {
        case true:  return HistoricalConstructorStandingsViewModel()
        case false: return HistoricalConstructorDetailViewModel()
        }
    }
    
    func didSelectRowRace(at indexPath: IndexPath) -> HistoricalDetailViewModelVariety {
        switch id.isAll() {
        case true:  return HistoricalRacesViewModel()
        case false: return HistoricalRaceDetailViewModel()
        }
    }
}

// MARK: - Extension ViewForHeaderInSection

extension HistoricalViewModelType {
    func viewForHeaderDriver() -> HistoricalHeaderViewModel? {
        switch id.isAll() {
        case true:  return HistoricalHeaderViewModel(for: take.driverStandingsHeader, by: category, and: id)
        case false: return HistoricalHeaderViewModel(for: take.racesDetailDriverHeader, by: category, and: id)
        }
    }
    
    func viewForHeaderConstructor() -> HistoricalHeaderViewModel? {
        switch id.isAll() {
        case true:  return HistoricalHeaderViewModel(for: take.constructorStandingsHeader, by: category, and: id)
        case false: return HistoricalHeaderViewModel(for: take.racesDetailConstructorHeader, by: category, and: id)
        }
    }
    
    func viewForHeaderRace() -> HistoricalHeaderViewModel? {
        switch id.isAll() {
        case true:  return HistoricalHeaderViewModel(for: take.firstPlaceResultInRaceHeader, by: category, and: id)
        case false: return HistoricalHeaderViewModel(for: take.racesDetailHeader, by: category, and: id)
        }
    }
}
