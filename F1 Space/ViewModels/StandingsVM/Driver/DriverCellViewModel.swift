//
//  DriverCellViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 17.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class DriverCellViewModel: NSObject {
    
    private var driver: DriverStandings?
    
    init(driver: DriverStandings?) {
        self.driver = driver
    }
    
    var position: String? {
        return driver?.position
    }
    var firstName: String? {
        return driver?.driver.givenName
    }
    var  lastName: String? {
        return driver?.driver.familyName.uppercased()
    }
    var teamName: String? {
        return driver?.team.first?.name
    }
    var numberPts: String? {
        return driver?.points
    }
}
