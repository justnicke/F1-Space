//
//  SceneDelegate.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 08.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var send: (([String: Bool]) -> (Void))?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        let currentYear = Calendar.current.component(.year, from: Date())
//
//        API.requestFirstPlaceResultInSeason(year: String(currentYear)) { [weak self] (round, error) in
//            DispatchQueue.global().async {
//                let firstRound = round?
//                    .raceResultData
//                    .raceResultTable
//                    .races
//
//                if firstRound != nil && !(firstRound?.isEmpty ?? true) {
//                    DispatchQueue.main.async { self?.send?([String(currentYear): true]) }
//                } else {
//                    DispatchQueue.main.async { self?.send?([String(currentYear - 1): false]) }
//
//                }
//            }
//        }
//
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        send = {  [weak self] (point) in
//            self?.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//            self?.window?.windowScene = windowScene
//            self?.window?.rootViewController = TabBarController(point: point)
//            self?.window?.makeKeyAndVisible()
//        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        self.window?.rootViewController = HistoricalDriverStandingsViewController()
        self.window?.makeKeyAndVisible()
    }
}
