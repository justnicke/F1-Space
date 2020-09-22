//
//  PickerViewModelType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol PickerViewModelType {
    func numberOfRowsIn(state: PickerIndex, component: Int) -> Int
    func titleFor(state: PickerIndex, row: Int) -> String?
    func viewFor(state: PickerIndex, row: Int, for title: NSAttributedString, and attributes: [NSAttributedString.Key : Any]) -> NSAttributedString
    func requestForSelection(arr: [String?], state: PickerIndex, compeletion: @escaping () -> (Void))
}
