//
//  DuelViewModelCell.swift
//  Formula Century
//
//  Created by Nikita Sukachev on 25.03.2021.
//  Copyright © 2021 Nikita Sukachev. All rights reserved.
//

import Foundation

final class DuelViewModelCell {
    
    // MARK: - Public Properties
    
    var driverName: String?
    var teammateName: String?
    
    var driverQualiScore: String?
    var teammateQualiScore: String?
    
    var driverRaceScore: String?
    var teammateRaceScore: String?
    
    var driverItems: CurrentDriver?
    var driverID: String
    
    // MARK: - Private Properties
    
    // MARK: - Constructors
    
    init(driverItems: CurrentDriver?, indexPath: IndexPath, driverID: String) {
        self.driverID = driverID
        self.driverItems = driverItems
        
        setup(indexPath: indexPath)
    }
    
    // MARK: - Public Methods
    
    func setup(indexPath: IndexPath) {
        driverName = driverID.replacingOccurrences(of: "_", with: " ").capitalized
        teammateName = getTeammates(indexPath: indexPath, mainKey: "qualification").first?.replacingOccurrences(of: "_", with: " ").capitalized
        
        driverQualiScore = String(driverItems?.comparison.driverItems["qualification"]?[indexPath.item][driverID] ?? 0)
        
        teammateQualiScore = String(driverItems?
                                        .comparison
                                        .driverItems["qualification"]?[indexPath.item][getTeammates(indexPath: indexPath, mainKey: "qualification").first ?? ""] ?? 0)
        
        driverRaceScore = String(driverItems?.comparison.driverItems["race"]?[indexPath.item][driverID] ?? 0)
        
        teammateRaceScore = String(driverItems?
                                                .comparison
                                                .driverItems["race"]?[indexPath.item][getTeammates(indexPath: indexPath, mainKey: "race").first ?? ""] ?? 0)
    }
    
    // MARK: - Private Methods
    
    private func getTeammates(indexPath: IndexPath, mainKey: String) -> [String] {
        guard var teammates = driverItems?.comparison.driverItems[mainKey]?[indexPath.item].map ({ String($0.key) }) else {
            return []
        }

        for (i, e) in teammates.enumerated() {
            if e == driverID {
                teammates.remove(at: i)
            }
        }

        return teammates
    }
}
