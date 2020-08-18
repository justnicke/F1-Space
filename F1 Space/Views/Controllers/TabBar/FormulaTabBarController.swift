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
        
        viewControllers = [
            createNavController(vc: ArchiveViewController(), title: "Archive", image: #imageLiteral(resourceName: "newsTrue"), selectedImage: nil),
            createNavController(vc: StandingsViewController(), title: "Standings", image: #imageLiteral(resourceName: "standingFalse"), selectedImage: #imageLiteral(resourceName: "standingTrue")),
            createNavController(vc: NewsViewController(), title: "News", image: #imageLiteral(resourceName: "newsFalse"), selectedImage: #imageLiteral(resourceName: "newsTrue"))
        ]
    }

    // MARK: Private Methods
    
    private func createNavController(vc: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.selectedImage = selectedImage
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -12, right: 0)
        
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
