//
//  HistoricalViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalViewModel: TestProtocol {

    // MARK: - Private Properties
    
    private(set) var year: String?
    private(set) var category: HistoricalCategory?
    private(set) var id: String?
    private(set) var take: Collector = Collector()
    
    // MARK: - Constructors
    
    init(year: String?, category: HistoricalCategory.RawValue?, id: String?) {
        self.year = year
        self.category = HistoricalCategory(rawValue: category.unwrap.lowercased())
        self.id = id
    }
    
    // MARK: - Public Methods
    
    func request(completion: @escaping () -> (Void), callback: @escaping (String) -> (Void)) {
        switch category {
        case .drivers:
            compareDriverID(completion: completion)
        case .teams:
            compareConstructorID(completion: completion)
        case .races:
            compareRaceID(completion: completion)
        default:
            fatalError("This shouldn't happen at all! Func: \(#function)")
        }
    }
    
    // MARK: - Private Methods
    
    // DRIVER
    
    private func compareDriverID(completion: @escaping () -> (Void)) {
        switch id.isAll() {
        case true: requestDriverStandings(completion: completion)
        case false: requestDriverDetail(completion: completion)
        }
    }

    private func requestDriverStandings(completion: @escaping () -> (Void)) {
        API.requestDriverStandings(year: self.year.unwrap) { [weak self] (driverStandingsGroup, error) in
            DispatchQueue.global().async {
                guard let driverStandings = driverStandingsGroup?
                        .driverStandingsData
                        .driverStandingsTable
                        .driverStandingsLists
                        .compactMap({ $0.driverStandings })
                        .reduce([], +) else {
                    return
                }
                
                self?.take.driverStandings = driverStandings
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    private func requestDriverDetail(completion: @escaping () -> (Void)) {
        API.requestDriverDetailResult(year: year.unwrap, id: id.unwrap) { [weak self] (driverDetail, error) in
            DispatchQueue.global().async {
                guard let racesInfo = driverDetail?
                        .driverDetailData
                        .driverDetailTable
                        .races else {
                    return
                }
                
                self?.take.racesDetailDriver = racesInfo
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    // CONSTRUCTOR
    
    private func compareConstructorID(completion: @escaping () -> (Void)) {
        switch id.isAll() {
        case true: requestConstructorStandings(completion: completion)
        case false: requestConstructorDetail(completion: completion)
        }
    }
    
    private func requestConstructorStandings(completion: @escaping () -> (Void)) {
        API.requestConstructorStandings(year: year.unwrap) { [weak self] (constructorStandingsGroup, error) in
            DispatchQueue.global().async {
                guard let constructorStandings = constructorStandingsGroup?
                        .constructorStandingsData
                        .constructorStandingsTable
                        .constructorStandingsLists
                        .compactMap({ $0.constructorStandings })
                        .reduce([], +) else {
                    return
                }
                
                self?.take.constructorStandings = constructorStandings
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    private func requestConstructorDetail(completion: @escaping () -> (Void)) {
        API.requestConstructorDetailResult(year: year.unwrap, id: id.unwrap) { [weak self] (constructorDetail, error) in
            DispatchQueue.global().async {
                guard let racesInfo = constructorDetail?
                        .constructorDetailData
                        .constructorDetailTable
                        .races else {
                    return
                }
                
                self?.take.racesDetailConstructors = racesInfo
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    // RACE
    
    private func compareRaceID(completion: @escaping () -> (Void)) {
        switch id.isAll() {
        case true: requestRaces(completion: completion)
        case false: requestRacesDetail(completion: completion)
        }
    }
    
    private func requestRaces(completion: @escaping () -> (Void)) {
        API.requestFirstPlaceResultInSeason(year: year.unwrap) { [weak self] (raceResult, error) in
            DispatchQueue.global().async {
                guard let raceInfo = raceResult?
                        .raceResultData
                        .raceResultTable
                        .races else {
                    return
                }
                
                self?.take.firstPlaceResultInRace = raceInfo
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    private func requestRacesDetail(completion: @escaping () -> (Void)) {
        API.requestConcreteRaceResults(year: year.unwrap, roundId: id.unwrap) {  [weak self] (raceDetail, error) in
            DispatchQueue.global().async {
                guard let results = raceDetail?
                        .racesDetailData
                        .racesDetaiTable
                        .races
                        .compactMap({ $0.results })
                        .reduce([], +) else {
                    return
                }
                self?.take.racesDetail = results
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}

// MARK: - Extension HistoricalViewModelType

extension HistoricalViewModel: HistoricalViewModelType {
    func numberOfRows() -> Int {
        switch category {
        case .drivers:
            switch id.isAll() {
            case true:  return take.driverStandings.count
            case false: return take.racesDetailDriver.count
            }
        case .teams:
            switch id.isAll() {
            case true:  return take.constructorStandings.count
            case false: return take.racesDetailConstructors.count
            }
        case .races:
            switch id.isAll() {
            case true:  return take.firstPlaceResultInRace.count
            case false: return take.racesDetail.count
            }
        default: return 0
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> HistoricalCellViewModel? {
        switch category {
        case .drivers:
            switch id.isAll() {
            case true:  return HistoricalCellViewModel(driverStanding: take.driverStandings[indexPath.row], category: category?.rawValue, id: id)
            case false: return HistoricalCellViewModel(raceDetailDriver: take.racesDetailDriver[indexPath.row], category: category?.rawValue, id: id)
            }
        case .teams:
            switch id.isAll() {
            case true:  return HistoricalCellViewModel(constructorStandings: take.constructorStandings[indexPath.row], category: category?.rawValue, id: id)
            case false: return HistoricalCellViewModel(raceDetailConstructor: take.racesDetailConstructors[indexPath.row], category: category?.rawValue, id: id)
            }
        case .races:
            switch id.isAll() {
            case true:  return HistoricalCellViewModel(race: take.firstPlaceResultInRace[indexPath.row], category: category?.rawValue, id: id)
            case false: return HistoricalCellViewModel(raceDetail: take.racesDetail[indexPath.row], category: category?.rawValue, id: id)
            }
        default: return nil
        }
    }
    
    func viewForHeader(in section: Int) -> HistoricalHeaderViewModel? {
        switch category {
        case .drivers:
            switch id.isAll() {
            case true:  return HistoricalHeaderViewModel(driverStandingsHeader: take.driverStandingsHeader, category: category?.rawValue, id: id)
            case false: return HistoricalHeaderViewModel(raceDetailDriver: take.racesDetailDriverHeader, category: category?.rawValue, id: id)
            }
        case .teams:
            switch id.isAll() {
            case true:  return HistoricalHeaderViewModel(constructorStandingsHeader: take.constructorStandingsHeader, category: category?.rawValue, id: id)
            case false: return HistoricalHeaderViewModel(racesDetailConstructorHeader: take.racesDetailConstructorHeader, category: category?.rawValue, id: id)
            }
        case .races:
            switch id.isAll() {
            case true:  return HistoricalHeaderViewModel(raceHeader: take.firstPlaceResultInRaceHeader, category: category?.rawValue, id: id)
            case false: return HistoricalHeaderViewModel(racesDetailHeader: take.racesDetailHeader, category: category?.rawValue, id: id)
            }
        default: return nil
        }
    }
}
