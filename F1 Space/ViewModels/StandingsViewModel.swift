//
//  StandingsViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class StandingsViewModel: NSObject {
    
    var drivers: [DriverStandings]?
    
    override init() {
        super.init()
        fetchData2()
    }
     
    func fetchData2() {
        API.requestDriverStandings { [weak self] (driver, err) in
            let convert = driver?.driverData.driverStandingsTable.driverStandingsLists.compactMap { $0.driverStandings }
            let convertedDrivers = convert?.reduce([], +)
            self?.drivers = convertedDrivers
//            print(self?.drivers)
        }
    }
       
    func collectionForCell() -> StandingsCellViewModel? {
        print(drivers)
        return StandingsCellViewModel(drivers: drivers)
    }
       
}



