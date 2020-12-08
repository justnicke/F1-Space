//
//  HistoricalViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalViewModel {
    
    // MARK: - Public Properties
    
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
    
    func request(completion: @escaping () -> (Void)) {
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
        case .drivers: return numberOfRowsDrivers()
        case .teams:   return numberOfRowsConstructors()
        case .races:   return numberOfRowsRaces()
        default:       return 0
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> HistoricalCellViewModel? {
        switch category {
        case .drivers: return cellForRowDriver(at: indexPath)
        case .teams:   return cellForRowConstructor(at: indexPath)
        case .races:   return cellForRowRace(at: indexPath)
        default:       return nil
        }
    }
    
    func viewForHeader() -> HistoricalHeaderViewModel? {
        switch category {
        case .drivers: return viewForHeaderDriver()
        case .teams:   return viewForHeaderConstructor()
        case .races:   return viewForHeaderRace()
        default:       return nil
        }
    }
}

