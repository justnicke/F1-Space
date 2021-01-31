//
//  HistoricalViewModelProperty.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 31.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalViewModelProperty {
    var year: String? { get }
    var category: HistoricalCategory? { get }
    var id: String? { get }
    var take: Collector { get }
}
