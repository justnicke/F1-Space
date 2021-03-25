//
//  HistoricalEnums.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 13.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Determines the state of the picker view
enum HistoricalPickerSelected: Int {
    case yearChampionship = 0
    case category = 1
    case detailedResult = 2
}

/// If the user has selected a "category"  from "HistoricalPickerSelected", then the following types will be available
enum HistoricalCategory: String {
    case drivers, teams, races
}
