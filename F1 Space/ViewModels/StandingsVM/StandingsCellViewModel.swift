//
//  StandingsCellViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 18.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class StandingsCellViewModel {
    
    var driverViewModel = DriverViewModel()
    var constructorViewModel = ConstructorViewModel()
    
    init(drivers: [DriverStandings]?) {
        driverViewModel.drivers = drivers
    }
    
    init(contructors: [ConstructorStandings]?) {
        constructorViewModel.constructors = contructors
    }
}
