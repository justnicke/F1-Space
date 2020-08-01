//
//  Extension + Size.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

extension CGSize {
    /// Returns the lesser of the two given values
    var min: CGFloat {
        return CGFloat.minimum(width, height)
    }
}
