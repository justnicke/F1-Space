//
//  Driver.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

struct Standings {
    var drivers: [Driver]
    var constructors: [Constructor]
}

struct Driver {
    let firstName: String?
    let lastName: String?
    let position: String?
    let pts: String?
    let team: String?
    let teamColor: UIColor?
}

struct Constructor {
    let position: String?
    let pts: String?
    let team: String?
    let teamColor: UIColor?
}


