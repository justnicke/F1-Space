//
//  HistoricalCurrentDriverConfiguratorType.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 23.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalCurrentDriverConfiguratorType:
    HistoricalCurrentDriverResultConfigurable,
    HistoricalCurrentDriverItemsConfigutable {

    func setModel() -> CurrentDriver
    
    /// Getting the data where the selected driver is present
    /// - Parameter results: Data model
    func configure(_ results: [[ResultF1]])
    
    /// Dictionary configuration when comparing the driver with teammates
    /// - Parameter results: Filtered data model
    func configureComparison(_ results: [[ResultF1]])
}
