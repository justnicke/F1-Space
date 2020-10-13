//
//  HistoricalViewModelType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 13.10.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalViewModelType {
    func numberOfItems(currentCategory: String?) -> Int
    func cellForItemAt(indexPath: IndexPath, for currentCategory: String?) -> HistoricalCellViewModel?
}
