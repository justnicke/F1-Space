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

final class NavigationView: UIView {
    
    // MARK: - Public Properties
    
    var itemTapped: ((_ tab: Int) -> Void)?
    
    // MARK: - Private Properties
    
    private let decorationView = EMTNeumorphicView()
    private var activeItem: Int = 0
    
    private let historicalButton = EMTNeumorphicButton(type: .custom)
    private let any1Button = EMTNeumorphicButton(type: .custom)
    private let any2Button = EMTNeumorphicButton(type: .custom)
    private let any3Button = EMTNeumorphicButton(type: .custom)
    
    // MARK: - Constructors
        
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .tabBarDark
        layer.cornerRadius = 10
        
        setupDecorationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(items: [ControllerType], frame: CGRect) {
        self.init(frame: frame)
        
        setButtons(with: items, and: frame)
        
        historicalButton.addTarget(self, action: #selector(pressHistorical(_:)), for: .touchUpInside)
        any1Button.addTarget(self, action: #selector(handleTap2(_:)), for: .touchUpInside)
        any2Button.addTarget(self, action: #selector(handleTap3(_:)), for: .touchUpInside)
        any3Button.addTarget(self, action: #selector(handleTap4(_:)), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    
    private func setupDecorationView() {
        addSubview(decorationView)
        decorationView.setDesignForDecorationView(with: backgroundColor)
        decorationView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            size: .init(width: 0, height: 54)
        )
    }
    
    private func setButtons(with items: [ControllerType], and frame: CGRect) {
        for i in 0..<items.count {
            let itemWidth = self.frame.width / CGFloat(items.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            let buttons = createButtons(item: items[i])
            
            decorationView.addSubview(buttons[i])
            buttons[i].setDesignInTabBar(with: backgroundColor)
            buttons[i].clipsToBounds = true
            buttons[i].tag = i
            buttons[i].layer.cornerRadius = 10
            buttons[i].anchor(
                top: decorationView.topAnchor,
                leading: decorationView.leadingAnchor,
                bottom: nil,
                trailing: nil,
                padding: .init(top: 5, left: leadingAnchor + 25, bottom: 0, right: 0),
                size: .init(width: 40, height: 40)
            )
        }
        
        historicalButton.isSelected = true
        activateButton(tag: 0)
    }
    
    private func createButtons(item: ControllerType) -> [EMTNeumorphicButton] {
        return [historicalButton, any1Button, any2Button, any3Button]
    }
    
    private func switchButton(from: Int, to: Int) {
        deactivateButton()
        activateButton(tag: to)
    }
    
    private func activateButton(tag: Int) {
        self.itemTapped?(tag)
        self.activeItem = tag
    }
    
    private func deactivateButton() {
        historicalButton.isSelected = false
        any1Button.isSelected = false
        any2Button.isSelected = false
        any3Button.isSelected = false
    }

    @objc private func pressHistorical(_ button: EMTNeumorphicButton) {
        switchButton(from: activeItem, to: button.tag)
        historicalButton.isSelected = true
    }
    
    @objc private func handleTap2(_ sender: EMTNeumorphicButton) {
        switchButton(from: activeItem, to: sender.tag)
        any1Button.isSelected = true
    }
    
    @objc private func handleTap3(_ sender: EMTNeumorphicButton) {
        switchButton(from: activeItem, to: sender.tag)
        any2Button.isSelected = true
    }
    
    @objc private func handleTap4(_ sender: EMTNeumorphicButton) {
        switchButton(from: activeItem, to: sender.tag)
        any3Button.isSelected = true
    }
}
