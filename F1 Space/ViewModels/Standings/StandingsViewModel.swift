//
//  StandingsViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class StandingsViewModel: DataSourceViewModelType {
    
    // MARK: - Private Properties
    
    private var drivers: [DriverStandings]?
    private var constructors: [ConstructorStandings]?
    
    // MARK: - Public Methods
    
    func requestData(compeletion: @escaping () -> (Void)) {
        API.requestDriverStandings(year: "2020") { [weak self] (driver, err) in
            let drivers = driver?.driverStandingsData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
            let convertedDrivers = drivers?.reduce([], +)
            self?.drivers = convertedDrivers
            compeletion()
        }
        
        API.requestConstructorStandings(year: "2020") { [weak self] (constructor, err) in
            let constructors = constructor?.constructorStandingsData.constructorStandingsTable.constructorStandingsLists.compactMap { $0.constructorStandings }
            let convertedconstructors = constructors?.reduce([], +)
            self?.constructors = convertedconstructors
            compeletion()
        }
    }
    
    func numberOfItems() -> Int {
        return 2
    }
    
    func cellForItemAt(indexPath: IndexPath) -> StandingsCellViewModel? {
        if indexPath.item == 0 {
            return StandingsCellViewModel(drivers: drivers)
        } else {
            return StandingsCellViewModel(contructors: constructors)
        }
    }
}




