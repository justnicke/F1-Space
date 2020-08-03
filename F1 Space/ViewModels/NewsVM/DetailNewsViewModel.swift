//
//  DetailNewsViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 03.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class DetailNewsViewModel {
    
    // MARK: - Public Properties
    
    var urlString: String?
    var resourceName: String?
    
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    init() { }
}
