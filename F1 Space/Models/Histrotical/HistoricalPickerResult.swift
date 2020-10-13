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
    var championships = [Int]()
    
    /// Category of choice for the user
    ///
    /// Read-only property
    let category = ["Drivers", "Teams", "Races"]
    
    /// Detailed result depending on the category selection
    var detailedResult: [String]
}
