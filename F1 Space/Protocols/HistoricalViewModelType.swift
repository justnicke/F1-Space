//
//  HistoricalViewModelType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 13.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalViewModelType {
    func numberOfRows() -> Int
    func cellForRowAt(indexPath: IndexPath) -> HistoricalCellViewModel?
    func viewForHeader(in section: Int) -> HistoricalHeaderViewModel?
}

protocol TestProtocol {
    var year: String? { get }
    var category: HistoricalCategory? { get }
    var id: String? { get }
    var take: Collector { get }
}


//extension HistoricalViewModelType {
//
//    func cellForRowAt(indexPath: IndexPath) -> HistoricalCellViewModel? {
//        switch category {
//        case .drivers:
//            switch id.isAll() {
//            case true:
//                let driver = take.driverStandings[indexPath.row]
//                return HistoricalCellViewModel(driverStanding: driver, category: category?.rawValue, id: id)
//            case false:
//                let detailDriver = take.racesDetailDriver[indexPath.row]
//                return HistoricalCellViewModel(raceDetailDriver: detailDriver, category: category?.rawValue, id: id)
//            }
//        case .teams:
//            switch id.isAll() {
//            case true:
//                let constructor = take.constructorStandings[indexPath.row]
//                return HistoricalCellViewModel(constructorStandings: constructor, category: category?.rawValue, id: id)
//            case false:
//                let detailConstructor = take.racesDetailConstructors[indexPath.row]
//                return HistoricalCellViewModel(raceDetailConstructor: detailConstructor, category: category?.rawValue, id: id)
//            }
//        case .races:
//            switch id.isAll() {
//            case true:
//                let race = take.firstPlaceResultInRace[indexPath.row]
//                return HistoricalCellViewModel(race: race, category: category?.rawValue, id: id)
//            case false:
//                let raceDetail = take.racesDetail[indexPath.row]
//                return HistoricalCellViewModel(raceDetail: raceDetail, category: category?.rawValue, id: id)
//            }
//        default: return nil
//        }
//    }
//}
