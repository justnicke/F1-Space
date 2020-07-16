//
//  FormulaTabBarController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class FormulaTabBarController: UITabBarController {
    
    // MARK: Public Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .red
        tabBar.backgroundColor = .white
        viewControllers = [createNavController(vc: StandingsViewController(), title: "Standings", image: #imageLiteral(resourceName: "helmet-2")),
                           createNavController(vc: UIViewController(), title: "News", image: #imageLiteral(resourceName: "helmet-2"))]
    }
    
    // MARK: Private Methods
    
    private func createNavController(vc: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        
        let titleFontAttrs = [
            NSAttributedString.Key.font: UIFont(name: "Formula1-Display-Bold", size: 25)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        appearance.titleTextAttributes = titleFontAttrs
        appearance.shadowColor = UIColor.clear
        
        navigationController.navigationBar.standardAppearance = appearance
        
        vc.navigationItem.title = title
        
        return navigationController
    }
}
