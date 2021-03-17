//
//  HistoricalPickerViewModelRequest.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 31.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalPickerViewModelRequest: HistoricalPickerProperty {
    func requestForSelection(completion: @escaping () -> (Void))
    func sendValueFromPicker(row: Int)
    func selectedRowPicker() -> Array<Int>.Index
}
