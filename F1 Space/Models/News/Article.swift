//
//  Article.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 29.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct Article {
    var title: String
    var description: String
    var published: Date?
    var url: String
    
    var isEmpty: Bool {
        return title.isEmpty || description.isEmpty || url.isEmpty == nil
    }
    
    mutating func reset() {
        title = ""
        description = ""
        published = nil
        url = ""
    }
}
