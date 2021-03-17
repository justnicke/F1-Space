//
//  Array.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 27.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    /// Removes duplicate elements from the array
    func dropDuplicates() -> [Element] {
        let addedSet = Set<Element>(self)
        return Array(addedSet)
    }
}
