//
//  PickerTypeDelegate.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

protocol PickerTypeDelegate: class {
    func year(value: Int)
    func type(result: String)
    func result(value: String)
}
