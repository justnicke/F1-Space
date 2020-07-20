//
//  StandingsViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol CollectionDataSourceViewModelType {
    associatedtype CellItem
    func numberOfItems() -> Int
    func cellForItemAt(indexPath: Int?) -> CellItem?
}

final class StandingsViewModel: CollectionDataSourceViewModelType {

    private var drivers: [DriverStandings]?
         
    func fetchData(compeletion: @escaping () ->()) {
        API.requestDriverStandings { [weak self] (driver, err) in
            let convert = driver?.driverData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
            let convertedDrivers = convert?.reduce([], +)
            self?.drivers = convertedDrivers
            compeletion()
        }
    }
    
    func numberOfItems() -> Int {
        return 2
    }
    
    func cellForItemAt(indexPath: Int?) -> StandingsCellViewModel? {
        return StandingsCellViewModel(drivers: drivers)
    }
}



