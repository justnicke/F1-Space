//
//  CustomTabBarController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.12.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    
    let controllerType: [ControllerType] = [.historical, .standings, .news, .any]
    var navigationView: NavigationView!
    var tabBarHeight: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBar()
        
//        view.backgroundColor = .yellow
    }
    
    func loadBar() {
        setupCustomTabMenu(controllerType) { (controllers) in
            self.viewControllers = controllers
        }
        selectedIndex = 0 // default our selected index to the first item
    }
    
    func setupCustomTabMenu(_ items: [ControllerType], completion: @escaping ([UIViewController]) -> Void) {
        
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        
        tabBar.isHidden = true
        
        navigationView = NavigationView(menuItems: controllerType, frame: frame)
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.clipsToBounds = true
        navigationView.itemTapped = changeTab
        
        view.addSubview(navigationView)
        navigationView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor).isActive = true
        navigationView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        navigationView.widthAnchor.constraint(equalToConstant: tabBar.frame.width).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: tabBarHeight).isActive = true
        
        for i in 0 ..< items.count {
            controllers.append(items[i].viewController)
        }
        
        view.layoutIfNeeded()
        completion(controllers)
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}
