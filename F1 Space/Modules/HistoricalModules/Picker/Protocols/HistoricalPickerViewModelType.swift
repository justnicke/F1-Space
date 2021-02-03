//
//  HistoricalPickerViewModelType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 31.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

/// Common interface PickerViewModel for properties, delegate, and dataSource
protocol PickerViewModelType:
    HistoricalPickerViewModelDataSource,
    HistoricalPickerViewModelDelegate,
    HistoricalPickerProperty {}
