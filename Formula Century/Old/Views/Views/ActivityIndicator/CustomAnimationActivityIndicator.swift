//
//  CustomAnimationActivityIndicator.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class CustomAnimationActivityIndicator {
    
    // MARK: - Private Nested
    
    private enum AnimationType: String {
        case spring = "spring"
        case rotation = "rotation"
    }
    
    private enum KeyAnimation: String {
        case strokeStart = "strokeStart"
        case strokeEnd = "strokeEnd"
        case rotationZ = "transform.rotation.z"
    }
    
    // MARK: - Public Methods
    
    func addAnimation(layer: CALayer) {
        layer.add(springAnimation(), forKey: AnimationType.spring.rawValue)
        layer.add(rotationAnimation(), forKey: AnimationType.rotation.rawValue)
    }
    
    func removeAnimation(layer: CALayer) {
        layer.removeAnimation(forKey: AnimationType.spring.rawValue)
        layer.removeAnimation(forKey: AnimationType.rotation.rawValue)
    }
    
    // MARK: - Private Methods
    
    private func rotationAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: KeyAnimation.rotationZ.rawValue)
        animation.duration = 4
        animation.fromValue = 0
        animation.toValue = (2.0 * .pi)
        animation.repeatCount = .infinity
        
        return animation
    }
    
    private func springAnimation() -> CAAnimationGroup {
        let animation = CAAnimationGroup()
        animation.duration = 1.5
        animation.repeatCount = .infinity
        animation.animations = [
            strokeStartAnimation(),
            strokeEndAnimation(),
            strokeCatchAnimation(),
            strokeFreezeAnimation()
        ]
        
        return animation
    }
    
    private func strokeStartAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: KeyAnimation.strokeStart.rawValue)
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 0.15
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    private func strokeEndAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: KeyAnimation.strokeEnd.rawValue)
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    private func strokeCatchAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: KeyAnimation.strokeStart.rawValue)
        animation.beginTime = 1
        animation.duration = 0.5
        animation.fromValue = 0.15
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    private func strokeFreezeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: KeyAnimation.strokeEnd.rawValue)
        animation.beginTime = 1
        animation.duration = 0.5
        animation.fromValue = 1
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
}
