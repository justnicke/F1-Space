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
        
        viewControllers = [createNavController(vc: StandingsViewController(), title: "STANDINGS"),
                           createNavController(vc: UIViewController(), title: "News")]
    }
    
    // MARK: Private Methods
    
    private func createNavController(vc: UIViewController, title: String) -> UIViewController { //, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem.title = title
        //        navigationController.tabBarItem.image = image
        
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
