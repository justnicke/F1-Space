//
//  HistoricalPickerProperty.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 31.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalPickerProperty: class {
    var currentValues: [String?] { get }
    var state: HistoricalPickerSelected? { get }
    var pickerResult: HistoricalPickerResult { get set }
}
