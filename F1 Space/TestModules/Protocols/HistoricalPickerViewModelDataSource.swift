//
//  HistoricalPickerViewModelDataSource.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 31.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalPickerViewModelDataSource {
    func numberOfComponents() -> Int
    func numberOfRowsInComponent(_ component: Int) -> Int
}
