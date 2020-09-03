//
//  InstantPanGestureRecognizer.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 03.09.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

extension CGPoint {
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        return CGPoint(
            x: x.projectedOffset(decelerationRate: decelerationRate),
            y: y.projectedOffset(decelerationRate: decelerationRate)
        )
    }
}

/// Velocity value
extension CGFloat {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        /// Magic formula from WWDC
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1000
        
        return self * multiplier
    }
}

