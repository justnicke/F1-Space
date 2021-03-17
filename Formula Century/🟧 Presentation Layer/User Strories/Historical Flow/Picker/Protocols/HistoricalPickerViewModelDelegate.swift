//
//  HistoricalPickerViewModelDelegate.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 31.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalPickerViewModelDelegate {
    func titleForRow(_ row: Int) -> String?
    func viewForRow(_ row: Int, with title: NSAttributedString, and attributes: [NSAttributedString.Key : Any]) -> NSAttributedString
    func rowHeightForComponent() -> Int
}
