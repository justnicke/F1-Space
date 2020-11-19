//
//  PickerViewModelType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol PickerViewModelType: PickerPropertyInitable {
    func numberOfRowsInComponent(_ component: Int) -> Int
    func titleForRow(_ row: Int) -> String?
    func viewForRow(_ row: Int, with title: NSAttributedString, and attributes: [NSAttributedString.Key : Any]) -> NSAttributedString
}

protocol PickerViewModelRequestType: PickerPropertyInitable {
    func requestForSelection(completion: @escaping () -> (Void))
    func sendValueFromPicker(row: Int)
    func selectedRowPicker() -> Array<Int>.Index
}

protocol PickerPropertyInitable: class {
    var currentValues: [String?] { get }
    var state: HistoricalPickerSelected? { get }
    var pickerResult: HistoricalPickerResult { get set }
}


