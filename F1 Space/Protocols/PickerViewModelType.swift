//
//  PickerViewModelType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation
protocol PickerViewModelType {
    func numberOfRowsInComponent(_ component: Int, by state: PickerIndex) -> Int
    func titleForRow(_ row: Int, by state: PickerIndex) -> String?
    func viewForRow(_ row: Int, with title: NSAttributedString, and attributes: [NSAttributedString.Key : Any], by state: PickerIndex) -> NSAttributedString
    func requestForSelection(from values: [String?], by state: PickerIndex, compeletion: @escaping () -> (Void))
}
