//
//  HistoricalCurrentDriverViewModelDataSource.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 25.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol HistoricalCurrentDriverViewModelDataSource {
    func numberOfRows() -> Int
    func cellForRowAt(indexPath: IndexPath) -> DuelViewModelCell
}
