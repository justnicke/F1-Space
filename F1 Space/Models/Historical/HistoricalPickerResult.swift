//
//  HistoricalPickerResult.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct HistoricalPickerResult {
    /// Officially the number of seasons in Formula One
    var totalSeasons: String?
    
    /// Championship years
    var championships = [String]()
    
    /// Category of choice for the user
    let category = ["Drivers", "Teams", "Races"]
    
    /// Detailed result depending on the category selection
    var detailedResult: [String]
    
    /// Designed to identify a specific driver, constructor or race
    var detailedResultID: [String]
}
