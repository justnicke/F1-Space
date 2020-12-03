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
    static let tabBarDark = UIColor.init(red: 0.1330153346, green: 0.1570890248, blue: 0.1913200021, alpha: 1)
//    var tets = #colorLiteral(red: 0.1613953412, green: 0.1643126309, blue: 0.1867728829, alpha: 1)
}

extension UIColor {
    /// Main color in a dark theme
    static let mainDark = UIColor.init(red: 0.1701667905, green: 0.1634520888, blue: 0.2283932865, alpha: 1)
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
