//
//  NewsViewModel.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 03.08.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class NewsViewModel: DataSourceViewModelType {
    
    // MARK: - Public Properties
        
    // MARK: - Private Properties
    
    private var articles: [Article] = []
    private var articlesReset: Bool = false
    private var dateRequest = Date()
    

    
    // MARK: - Public Methods
    
    func requestData(compeletion: @escaping () ->()) {
        guard articles.isEmpty || DateInterval(start: dateRequest, end: Date()).duration > TimeInterval(floatLiteral: 3) else {
            return
        }
        
        articlesReset  = true
                
        DispatchQueue.main.async {
            for feed in RSS.feeds {
                let rss = RSS()
                rss.requestNews(feed: feed,
                                success: { [weak self] articles in
                                    DispatchQueue.main.async {
                                        guard let newsVC = self else { return }
                                        
                                        if newsVC.articlesReset {
                                            newsVC.articles = []
                                            newsVC.dateRequest = Date()
                                        }
                                        
                                        newsVC.articlesReset = false
                                        newsVC.articles = (newsVC.articles + articles).sorted { ($0.published ?? Date()) > ($1.published ?? Date()) }
                                        compeletion()
                                        
                                    }
                    },
                                failure: { [weak self] error in
                                    // add alert error
                                    print(error.localizedDescription)
                })
            }
        }
    }
    
    func numberOfItems() -> Int {
        return articles.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> NewsCellViewModel? {
        let article = articles[indexPath.row]
        return NewsCellViewModel(article: article)
    }
    
    func didSelectRowAt(indexPath: IndexPath) -> DetailNewsViewModel? {
        let article = self.articles[indexPath.row]
        let detailVM = DetailNewsViewModel(urlString: article.url)
        
        if article.url.contains("motorsport.com") {
            detailVM.resourceName = "motorsport"
        } else {
            detailVM.resourceName = "F1NEWS"
        }
        return detailVM
    }
}
