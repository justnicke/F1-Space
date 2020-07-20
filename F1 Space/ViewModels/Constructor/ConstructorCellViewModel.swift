//
//  ConstructorCellViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 20.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class ConstructorCellViewModel {
    
    private var constructor: ConstructorStandings?
    
    init(constructor: ConstructorStandings?) {
        self.constructor = constructor
    }
    
    var position: String? {
        return constructor?.position
    }
    var teamName: String? {
        return constructor?.constructor.name
    }
    var numberPts: String? {
        return constructor?.points
    }
}
