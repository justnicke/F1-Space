//
//  NavigationView.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.12.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

import UIKit
import EMTNeumorphicView

extension UIColor {
    static let offWhite = UIColor.init(red: 225/255, green: 225/255, blue: 235/255, alpha: 1)
}

final class NavigationView: UIView {
    
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    let decorationView = EMTNeumorphicView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

//        backgroundColor = .offWhite
        backgroundColor = .testColor
        layer.cornerRadius = 10
        // clipsToBounds = true

        addSubview(decorationView)
        decorationView.translatesAutoresizingMaskIntoConstraints = false

//        decorationView.neumorphicLayer?.elementBackgroundColor = UIColor.offWhite.cgColor
        decorationView.neumorphicLayer?.elementBackgroundColor = UIColor.testColor.cgColor
        decorationView.neumorphicLayer?.cornerRadius = 10
        decorationView.neumorphicLayer?.cornerType = .bottomRow
        decorationView.neumorphicLayer?.depthType = .concave
        decorationView.neumorphicLayer?.elementDepth = 5
        decorationView.neumorphicLayer?.darkShadowOpacity = 0.5
        decorationView.neumorphicLayer?.lightShadowOpacity = 0.05

        decorationView.translatesAutoresizingMaskIntoConstraints = false
        decorationView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        decorationView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        decorationView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        decorationView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(menuItems: [ControllerType], frame: CGRect) {
        self.init(frame: frame)

        for i in 0..<menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            let itemView = createButtons(item: menuItems[i])

            itemView[i].translatesAutoresizingMaskIntoConstraints = false
            itemView[i].clipsToBounds = true
            itemView[i].tag = i

            itemView[i].layer.cornerRadius = 10
            decorationView.addSubview(itemView[i])
            itemView[i].topAnchor.constraint(equalTo: decorationView.topAnchor, constant: 10).isActive = true
            itemView[i].leadingAnchor.constraint(equalTo: decorationView.leadingAnchor, constant: leadingAnchor + 25).isActive = true

            itemView[i].heightAnchor.constraint(equalToConstant: 45).isActive = true
            itemView[i].widthAnchor.constraint(equalToConstant: 45).isActive = true
        }

        setNeedsLayout()
        layoutIfNeeded()
        activateTab(tab: 0)
    }
    
        
    var firstButton = EMTNeumorphicButton(type: .custom)
    var secondButton = EMTNeumorphicButton(type: .custom)
    var thirdButton = EMTNeumorphicButton(type: .custom)
    var fourthButton = EMTNeumorphicButton(type: .custom)
    
    func createButtons(item: ControllerType) -> [EMTNeumorphicButton] {
        var arrayButton = [EMTNeumorphicButton]()
//
//        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
//        let image = UIImage(systemName: "arrow.right", withConfiguration: boldConfig)
        
        firstButton.neumorphicLayer?.elementBackgroundColor = backgroundColor?.cgColor ?? UIColor.testColor.cgColor
        firstButton.addTarget(self, action: #selector(handleTap1(_:)), for: .touchUpInside)
        firstButton.neumorphicLayer?.lightShadowOpacity = 0.08
        firstButton.neumorphicLayer?.darkShadowOpacity = 0.5
        arrayButton.append(firstButton)
        
        secondButton.neumorphicLayer?.elementBackgroundColor = backgroundColor?.cgColor ?? UIColor.testColor.cgColor
        secondButton.addTarget(self, action: #selector(handleTap2(_:)), for: .touchUpInside)
        secondButton.neumorphicLayer?.lightShadowOpacity = 0.08
        secondButton.neumorphicLayer?.darkShadowOpacity = 0.5
        arrayButton.append(secondButton)
        
        thirdButton.neumorphicLayer?.elementBackgroundColor = backgroundColor?.cgColor ?? UIColor.testColor.cgColor
        thirdButton.addTarget(self, action: #selector(handleTap3(_:)), for: .touchUpInside)
        thirdButton.neumorphicLayer?.lightShadowOpacity = 0.08
        thirdButton.neumorphicLayer?.darkShadowOpacity = 0.5
        arrayButton.append(thirdButton)
        
        fourthButton.neumorphicLayer?.elementBackgroundColor = backgroundColor?.cgColor ?? UIColor.testColor.cgColor
        fourthButton.addTarget(self, action: #selector(handleTap4(_:)), for: .touchUpInside)
        fourthButton.neumorphicLayer?.lightShadowOpacity = 0.08
        fourthButton.neumorphicLayer?.darkShadowOpacity = 0.5
        arrayButton.append(fourthButton)
        
        return arrayButton
    }


    
    @objc func handleTap1(_ sender: EMTNeumorphicButton) {
        switchTab(from: activeItem, to: sender.tag)
        firstButton.isSelected = true
    }
    
    @objc func handleTap2(_ sender: EMTNeumorphicButton) {
        switchTab(from: activeItem, to: sender.tag)
        secondButton.isSelected = true
    }
    
    @objc func handleTap3(_ sender: EMTNeumorphicButton) {
        switchTab(from: activeItem, to: sender.tag)
        thirdButton.isSelected = true
    }
    
    @objc func handleTap4(_ sender: EMTNeumorphicButton) {
        switchTab(from: activeItem, to: sender.tag)
        fourthButton.isSelected = true
    }
    
    func switchTab(from: Int, to: Int) {
        deactivateTab(tab: from)
        activateTab(tab: to)
    }
    
    func activateTab(tab: Int) {
        self.itemTapped?(tab)
        self.activeItem = tab
    }

    
    func deactivateTab(tab: Int) {
        firstButton.isSelected = false
        secondButton.isSelected = false
        thirdButton.isSelected = false
        fourthButton.isSelected = false
    }
}
