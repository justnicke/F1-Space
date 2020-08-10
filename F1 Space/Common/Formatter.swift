//
//  Formatter.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 29.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct Formatter {
    static func days(for number: Int) -> String {
        return organization(number: number, keys: ("day", "days", "days"))
    }
    
    static func hours(for number: Int) -> String {
        return organization(number: number, keys: ("hour", "hours", "hours"))
    }
    
    static func minutes(for number: Int) -> String {
        return organization(number: number, keys: ("minute", "minutes", "minutes"))
    }
    
    static private func organization(number: Int, keys: (one: String, several: String, many: String)) -> String {
        switch number {
        case 1: return keys.one
        case 2, 3, 4: return keys.several
        default: return keys.many
        }
    }
}

