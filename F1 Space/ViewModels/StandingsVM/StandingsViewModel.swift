//
//  StandingsViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class StandingsViewModel: CollectionDataSourceViewModelType {
    
    // MARK: - Private Properties
    
    private var drivers: [DriverStandings]?
    private var constructors: [ConstructorStandings]?
    
    func requestData(compeletion: @escaping () ->()) {
        API.requestDriverStandings { [weak self] (driver, err) in
            let convert = driver?.driverData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
            let convertedDrivers = convert?.reduce([], +)
            self?.drivers = convertedDrivers
            compeletion()
        }
        
        API.requestConstructorStandings { [weak self] (constTeam, err) in
            let convert = constTeam?.constructorData.constructorStandingsTable.constructorStandingsLists.compactMap { $0.constructorStandings }
            let convertedconstructors = convert?.reduce([], +)
            self?.constructors = convertedconstructors
            compeletion()
        }
    }
    
    func numberOfItems() -> Int {
        return 2
    }
    
    func cellForItemAt(indexPath: IndexPath?) -> StandingsCellViewModel? {
        if indexPath?.item == 0 {
            return StandingsCellViewModel(drivers: drivers)
        } else {
            return StandingsCellViewModel(contructors: constructors)
        }
    }
}




