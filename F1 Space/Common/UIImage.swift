//
//  UIImage.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 19.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

extension UIImage {
    /// Method to simplify setting up system icons
    static func setIcon(_ systemName: String, thickness: UIImage.SymbolConfiguration) -> UIImage? {
        return UIImage(systemName: systemName, withConfiguration: thickness)
    }
}
