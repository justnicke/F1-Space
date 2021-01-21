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
    var send: ((String) -> (Void))?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let date = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        
        API.requestFirstPlaceResultInSeason(year: String(currentYear)) { [weak self] (round, error) in
            DispatchQueue.global().async {
                    let firstRound = round?
                        .raceResultData
                        .raceResultTable
                        .races

                if firstRound != nil && !(firstRound?.isEmpty ?? true) {
                    DispatchQueue.main.async { self?.send?(String(currentYear)) }
                } else {
                    DispatchQueue.main.async { self?.send?(String(currentYear - 1)) }
                    
                }
            }
        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        send = {  [weak self] (value) in
            self?.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            self?.window?.windowScene = windowScene
            self?.window?.rootViewController = TabBarController(str: value)
            self?.window?.makeKeyAndVisible()
        }
    }
}

