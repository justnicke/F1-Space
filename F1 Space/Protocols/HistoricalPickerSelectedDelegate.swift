//
//  HistoricalPickerDelegate.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalPickerSelectedDelegate: class {
    func year(currentСhampionship: Int)
    func category(current: String)
    func detailed(currentResult: String, id: String?)
}
