//
//  UIVIewGradient.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 20.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

extension UIView {
    func setGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.333333075, green: 0.3061279655, blue: 0.9117060304, alpha: 1).cgColor, UIColor.white.cgColor]
        gradient.locations = [0.5 , 0.35]
        gradient.frame = self.layer.frame
        self.layer.insertSublayer(gradient, at: 0)
    }
}
