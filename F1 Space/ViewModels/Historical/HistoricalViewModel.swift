//
//  HistoricalViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct Collector {
    // Header
    let driverStandingsHeader        = HistoricalStandingsHeader("POS", "Driver", "Constructor", "Points")
    let constructorStandingsHeader   = HistoricalStandingsHeader("POS", "Constructor", "Points")
    let firstPlaceResultInRaceHeader = HistoricalStandingsHeader("Grand Prix", "Winner", "Car")
    let racesDetailDriverHeader      = HistoricalStandingsHeader("Grand Prix", "POS", "Time", "Points")
    let racesDetailConstructorHeader = HistoricalStandingsHeader("Grand Prix", "Drivers", "POS", "Time", "Points")
    let racesDetailHeader            = HistoricalStandingsHeader("POS", "Drivers", "Time", "Points")
    
    // Table
    var driverStandings: [DriverStandings] = []
    var constructorStandings: [ConstructorStandings] = []
    var firstPlaceResultInRace: [Race] = []
    var racesDetailDriver: [Race] = []
    var racesDetailConstructors: [Race] = []
    var racesDetail: [Result] = []
}

final class HistoricalViewModel {
    
    // MARK: - Private Properties
    
    private var take = Collector()
        
    private var year: String?
    private var id: String?
    private var category: HistoricalCategory?
    

    // MARK: - Constructors
    
    init(year: String?, category: HistoricalCategory.RawValue?, id: String?) {
        self.year = year
        self.category = HistoricalCategory(rawValue: category.unwrap.lowercased())
        self.id = id
    }
    
//    func testRequest(year: String?, id: String?, callback: @escaping (String?) -> (Void)) {
//        guard let year = year,
//              let crucitId = id
//        else {
//            return
//        }
//        API.requestConcreteRaceResults(year: year, roundId: crucitId) { (crucit, err) in
//            let aa = crucit?.racesDetailData.racesDetaiTable.races.first?.round
//            if aa != nil{
//                callback(id)
//            } else {
//                callback("All")
//            }
//        }
//    }
    
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
    func numberOfRows(inCurrent category: String?, id: String?) -> Int {
        if category?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
                return take.driverStandings.count
            } else {
                return take.racesDetailDriver.count
            }
        } else if category?.lowercased() == HistoricalCategory.teams.rawValue {
            if id == "All" {
                return take.constructorStandings.count
            } else {
                return take.racesDetailConstructors.count
            }
        } else {
            if id == "All" {
                return take.firstPlaceResultInRace.count
            } else {
                return take.racesDetail.count
            }
        }
    }
    
    func cellForRowAt(indexPath: IndexPath, inCurrent currentCategory: String?, id: String?) -> HistoricalCellViewModel? {
        if currentCategory?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
                let driver = take.driverStandings[indexPath.row]
                return HistoricalCellViewModel(driverStanding: driver, category: currentCategory, id: id)
            } else {
                let detailDriver = take.racesDetailDriver[indexPath.row]
                return HistoricalCellViewModel(raceDetailDriver: detailDriver, category: currentCategory, id: id)
            }
        } else if currentCategory?.lowercased() == HistoricalCategory.teams.rawValue {
            if id == "All" {
                let constructor = take.constructorStandings[indexPath.row]
                return HistoricalCellViewModel(constructorStandings: constructor, category: currentCategory, id: id)
            } else {
                let detailConstructor = take.racesDetailConstructors[indexPath.row]
                return HistoricalCellViewModel(raceDetailConstructor: detailConstructor, category: currentCategory, id: id)
            }
        } else {
            if id == "All" {
                let race = take.firstPlaceResultInRace[indexPath.row]
                return HistoricalCellViewModel(race: race, category: currentCategory, id: id)
            } else {
                let raceDetail = take.racesDetail[indexPath.row]
                return HistoricalCellViewModel(raceDetail: raceDetail, category: currentCategory, id: id)
            }
        }
    }
    
    func viewForHeader(in section: Int, currentCategory: String?, id: String?) -> HistoricalHeaderViewModel? {
        if currentCategory?.lowercased() == HistoricalCategory.drivers.rawValue {
            if id == "All" {
                return HistoricalHeaderViewModel(driverStandingsHeader: take.driverStandingsHeader, category: currentCategory, id: id)
            } else {
                return HistoricalHeaderViewModel(raceDetailDriver: take.racesDetailDriverHeader, category: currentCategory, id: id)
            }
        } else if currentCategory?.lowercased() == HistoricalCategory.teams.rawValue {
            if id == "All" {
                return HistoricalHeaderViewModel(constructorStandingsHeader: take.constructorStandingsHeader, category: currentCategory, id: id)
            } else {
                return HistoricalHeaderViewModel(racesDetailConstructorHeader: take.racesDetailConstructorHeader, category: currentCategory, id: id)
            }
        } else {
            if id == "All" {
                return HistoricalHeaderViewModel(raceHeader: take.firstPlaceResultInRaceHeader, category: currentCategory, id: id)
            } else {
                return HistoricalHeaderViewModel(racesDetailHeader: take.racesDetailHeader, category: currentCategory, id: id)
            }
        }
    }
}


