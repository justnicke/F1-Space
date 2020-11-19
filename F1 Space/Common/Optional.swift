//
//  Optional.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 12.11.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    /// Unwrapping optional string
    ///
    /// If the property is nil, it returns an empty string
    var unwrap: String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }
    
    /// The picker detailed information is  "All"
     func isAll() -> Bool {
        switch unwrap == "All" {
        case true:  return true
        case false: return false
        }
    }
}

extension Optional where Wrapped == HistoricalPickerSelected {
    /// Unwrapping optional HistoricalPickerSelected
    ///
    /// If the property is nil, it returns yearChampionship
    var unwrap: HistoricalPickerSelected {
        guard let unwrapped = self else {
            return HistoricalPickerSelected.yearChampionship
        }
        return unwrapped
    }
}

extension Optional where Wrapped == [String] {
    /// Unwrapping optional HistoricalPickerSelected
    ///
    /// If the property is nil, it returns empty Array
    var unwrap: [String] {
        guard let unwrapped = self else {
            return [""]
        }
        return unwrapped
    }
}


