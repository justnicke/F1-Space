//
//  HistoricalDriverDetailViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 02.02.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

final class HistoricalDriverDetailViewModel: HistoricalDetailViewModelVariety {
    var someValue: String?
    
    init(someValue: String) {
        self.someValue = someValue
    }
    
    init() {}
}
