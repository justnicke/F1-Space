//
//  ControllerType.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 01.12.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

enum ControllerType: String, CaseIterable {
    case historical = "HistoricalViewController"
    case standings = "StandingsViewController"
    case news = "NewsViewController"
    case any = "AnyController"
    
    var viewController: UIViewController {
        switch self {
        case .historical:
            return createNavController(vc: HistoricalViewController(), title: "Historical")
        case .standings:
            return createNavController(vc: StandingsViewController(), title: "Standings")
        case .news:
            return createNavController(vc: NewsViewController(), title: "News")
        case .any:
            return createNavController(vc: AnyViewController(), title: "AnyVC")
        }
    }
    
    private func createNavController(vc: UIViewController,
                                     title: String,
                                     image: UIImage? = nil,
                                     selectedImage: UIImage? = nil) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.selectedImage = selectedImage
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -12, right: 0)
        
        let titleFontAttrs = [
            NSAttributedString.Key.font: UIFont(name: "Formula1-Display-Bold", size: 25)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .mainDark
        appearance.titleTextAttributes = titleFontAttrs
        appearance.shadowColor = UIColor.clear
        
        navigationController.navigationBar.standardAppearance = appearance
        vc.navigationItem.title = title
        
        return navigationController
    }
}

final class AnyViewController: UIViewController {}


