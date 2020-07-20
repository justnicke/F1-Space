//
//  ConstructorViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 20.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class ConstructorViewModel: CollectionDataSourceViewModelType {
    
    var constructors: [ConstructorStandings]?
    
    func numberOfItems() -> Int {
        return constructors?.count ?? 0
    }
    
    func cellForItemAt(indexPath: IndexPath?) -> ConstructorCellViewModel? {
        let constructor = constructors?[indexPath?.item ?? 0]
        return ConstructorCellViewModel(constructor: constructor)
    }
}
