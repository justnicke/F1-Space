//
//  ConstructorsColor.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 15.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

struct ConstructorsColor {
    static let Mercedes     = #colorLiteral(red: 0.03063297272, green: 0.8167604804, blue: 0.7451717854, alpha: 1)
    static let Ferrari      = #colorLiteral(red: 0.8616731763, green: 0.01273033582, blue: 0.0001983227558, alpha: 1)
    static let RedBull      = #colorLiteral(red: 0.06595106423, green: 0.002053977456, blue: 0.9318153262, alpha: 1)
    static let McLaren      = #colorLiteral(red: 0.9962134957, green: 0.5281645656, blue: 0.01665473171, alpha: 1)
    static let Renault      = #colorLiteral(red: 0.9965702891, green: 0.9572610259, blue: 0.0248617474, alpha: 1)
    static let AlphaTauri   = #colorLiteral(red: 0.8322325349, green: 0.8272122741, blue: 0.8358930349, alpha: 1)
    static let RacingPoint  = #colorLiteral(red: 0.9565749764, green: 0.5879674554, blue: 0.7851110101, alpha: 1)
    static let AlfaRomeo    = #colorLiteral(red: 0.5815549493, green: 0.008921941742, blue: 0, alpha: 1)
    static let HaasF1Team   = #colorLiteral(red: 0.4391747117, green: 0.4392418861, blue: 0.4391601086, alpha: 1)
    static let Williams     = #colorLiteral(red: 0, green: 0.5114021897, blue: 0.9768144488, alpha: 1)
    
    func teamColor(for constructor: String?) -> UIColor {
        switch constructor {
        case "Mercedes":
            return ConstructorsColor.Mercedes
        case "Ferrari":
            return ConstructorsColor.Ferrari
        case "Red Bull":
            return ConstructorsColor.RedBull
        case "McLaren":
            return ConstructorsColor.McLaren
        case "Racing Point":
            return ConstructorsColor.RacingPoint
        case "Renault":
            return ConstructorsColor.Renault
        case "AlphaTauri":
            return ConstructorsColor.AlphaTauri
        case "Williams":
            return ConstructorsColor.Williams
        case "Alfa Romeo":
            return ConstructorsColor.AlfaRomeo
        case "Haas F1 Team":
            return ConstructorsColor.HaasF1Team
        default:
            return .black
        }
    }
}

