//
//  DriverViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 17.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class DriverViewModel: CollectionDataSourceViewModelType {
    
    var drivers: [DriverStandings]?
    
    func numberOfItems() -> Int {
        return drivers?.count ?? 0
      }
      
    func cellForItemAt(indexPath: Int?) -> DriverCellViewModel? {
        let driver = drivers?[indexPath ?? 0]
        return DriverCellViewModel(driver: driver)
    }
}
