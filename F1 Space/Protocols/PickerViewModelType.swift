//
//  PickerViewModelType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation
protocol PickerViewModelType {
    func numberOfRowsInComponent(_ component: Int, by state: HistoricalPickerSelected) -> Int
    func titleForRow(_ row: Int, by state: HistoricalPickerSelected) -> String?
    func viewForRow(_ row: Int, with title: NSAttributedString, and attributes: [NSAttributedString.Key : Any], by state: HistoricalPickerSelected) -> NSAttributedString
    func requestForSelection(from values: [String?], by state: HistoricalPickerSelected, compeletion: @escaping () -> (Void))
}
