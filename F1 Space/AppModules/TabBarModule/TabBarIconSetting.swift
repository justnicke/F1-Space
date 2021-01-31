//
//  TabBarIconSetting.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 19.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

enum TabBarIconSetting {
    case historical
    case standings
    
    var icon: UIImage? {
        switch self {
        case .historical:
            return UIImage.setIcon("text.justify", thickness: .init(weight: .medium))
        case .standings:
            return UIImage.setIcon("table", thickness: .init(weight: .medium))
        }
    }
}
