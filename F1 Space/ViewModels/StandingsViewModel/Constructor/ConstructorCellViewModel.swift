//
//  ConstructorCellViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 20.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class ConstructorCellViewModel {
    
    // MARK: - Public Properties
    
    var position: String? {
        return constructor?.position
    }
    var teamName: String? {
        return constructor?.constructor.name
    }
    var numberPts: String? {
        return constructor?.points
    }
    
    // MARK: - Private Properties
    
    private var constructor: ConstructorStandings?
    
    // MARK: - Constructors
    
    init(constructor: ConstructorStandings?) {
        self.constructor = constructor
    }
}
