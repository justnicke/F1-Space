//
//  NewsCellViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 03.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class NewsCellViewModel {
    
    // MARK: - Public Properties
    
    var title: String {
        return article.title
    }
    var description: String {
        return article.description
    }
    var published: Date? {
        return article.published
    }
    var url: String {
        return article.url
    }
    
    // MARK: - Private Properties
    
    private var article: Article
    
    // MARK: - Constructors
    
    init(article: Article) {
        self.article = article
    }
}
