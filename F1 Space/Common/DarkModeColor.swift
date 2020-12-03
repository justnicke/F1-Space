//
//  DarkModeColor.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 03.12.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import EMTNeumorphicView


extension UIColor {
    /// The color is intended for the TabBar, including all elements on it
    static let tabBarDark = UIColor.init(red: 0.1338306069, green: 0.1532383263, blue: 0.17460078, alpha: 1)
}

extension EMTNeumorphicButton {
    /// TabBar button design
    func setDesignInTabBar(with superview: UIColor?) {
        self.neumorphicLayer?.elementBackgroundColor = superview?.cgColor ?? #colorLiteral(red: 0.1338306069, green: 0.1532383263, blue: 0.17460078, alpha: 1)
        self.neumorphicLayer?.lightShadowOpacity = 0.04
        self.neumorphicLayer?.darkShadowOpacity = 0.5
    }
}

extension EMTNeumorphicView {
    func setDesignForDecorationView(with superview: UIColor?) {
        self.neumorphicLayer?.elementBackgroundColor = superview?.cgColor ?? #colorLiteral(red: 0.1338306069, green: 0.1532383263, blue: 0.17460078, alpha: 1)
        self.neumorphicLayer?.cornerRadius = 10
        self.neumorphicLayer?.cornerType = .bottomRow
        self.neumorphicLayer?.depthType = .concave
        self.neumorphicLayer?.elementDepth = 5
        self.neumorphicLayer?.darkShadowOpacity = 0.5
        self.neumorphicLayer?.lightShadowOpacity = 0.05

    }
}
