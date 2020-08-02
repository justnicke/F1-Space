//
//  DriverViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 17.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class DriverViewModel: CollectionDataSourceViewModelType {
    
    // MARK: - Public Properties
    
    var drivers: [DriverStandings]?
    
    // MARK: - Public Methods
    
    func numberOfItems() -> Int {
        return drivers?.count ?? 0
      }
      
    func cellForItemAt(indexPath: IndexPath?) -> DriverCellViewModel? {
        let driver = drivers?[indexPath?.item ?? 0]
        return DriverCellViewModel(driver: driver)
    }
}
