//
//  CustomTabBarController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.12.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    
    // MARK: - Private Properties
    
    private let controllerType: [ControllerType] = [.historical, .standings, .news, .any]
    private var navigationView: NavigationView!
    private var barHeight: CGFloat = 74

    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBar()
    }
    
    // MARK: - Private Methods

    private func loadBar() {
        setupCustomTabBar(controllerType) { (controllers) in
            self.viewControllers = controllers
        }
        selectedIndex = 0
    }
    
    private func setupCustomTabBar(_ items: [ControllerType], completion: @escaping ([UIViewController]) -> Void) {
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        
        tabBar.isHidden = true

        navigationView = NavigationView(items: controllerType, frame: frame)
        
        navigationView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        view.addSubview(navigationView)
        navigationView.clipsToBounds = true
        navigationView.itemTapped = changeButton
        navigationView.anchor(
            top: nil,
            leading: tabBar.leadingAnchor,
            bottom: tabBar.bottomAnchor,
            trailing: tabBar.trailingAnchor,
            size: .init(width: tabBar.frame.width, height: barHeight)
        )
         
        for i in 0 ..< items.count {
            controllers.append(items[i].viewController)
        }
        
        view.layoutIfNeeded()
        completion(controllers)
    }
    
    private func changeButton(tag: Int) {
        self.selectedIndex = tag
    }
}
