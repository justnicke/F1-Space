//
//  TabBarController.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 19.01.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        
        viewControllers = [
            createNavController(vc: HistoricalViewController(), title: "History F1", image: .historical),
            createNavController(vc: StandingsViewController(), title: "Standings", image: .standings)
        ]
    }

    // MARK: - Private Methods
    
    private func createNavController(vc: UIViewController, title: String, image: TabBarIconSetting? = nil, selectedImage: UIImage? = nil) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem.image = image?.icon
        navigationController.tabBarItem.selectedImage = selectedImage
        navigationController.tabBarItem.title = ""
        navigationController.tabBarItem.imageInsets = .zero
        let titleFontAttrs = [
            NSAttributedString.Key.font: UIFont(name: "Formula1-Display-Bold", size: 25)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .topH
        appearance.titleTextAttributes = titleFontAttrs
        appearance.shadowColor = UIColor.clear
        
        navigationController.navigationBar.standardAppearance = appearance
        vc.navigationItem.title = title
        
        return navigationController
    }
}
