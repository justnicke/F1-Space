//
//  CollectionDataSourceViewModelType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 22.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol CollectionDataSourceViewModelType {
    associatedtype CellItem
    func numberOfItems() -> Int
    func cellForItemAt(indexPath: IndexPath?) -> CellItem?
}
