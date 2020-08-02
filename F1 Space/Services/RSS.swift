//
//  RSS.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 29.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

final class RSS: NSObject {
    
    // MARK: - Public Properties
    
    static var feeds: [Feed] {
        return Feed.resources
    }
    
    // MARK: - Private Properties
    
    private var items: [Article] = []
    private var currentArticle = Article(title: "", description: "", url: "")
    private var elementStack: [String] = []
    private var xmlParser: XMLParser?
    private var success: (([Article]) -> Void)?
    private var failure: ((Error) -> Void)?
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        return dateFormatter
    }()
    
    // MARK: - Public Nested
    
    enum Feed: String {
        case motorsportRu = "https://ru.motorsport.com/rss/f1/news/"
        case f1newsRu = "https://www.f1news.ru/export/news.xml"
        
        static var resources: [Feed] {
            return [.motorsportRu, .f1newsRu]
        }
        
        var url: URL? {
            return URL(string: rawValue)
        }
    }
    
    // MARK: - Public Methods
    
    func requestNews(feed: Feed, success: @escaping ([Article]) -> Void, failure: @escaping (Error) -> Void) {
        if let url = feed.url {
            self.success = success
            self.failure = failure
            xmlParser = XMLParser(contentsOf: url)
            xmlParser?.delegate = self
            xmlParser?.parse()
        }
    }
}

// MARK: - XML Parser Delegate

extension RSS: XMLParserDelegate {
    
    func parserDidStartDocument(_ parser: XMLParser) {
        items = []
        currentArticle.reset()
        elementStack = ["rss"]
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "item" {
            if currentArticle.isEmpty == false {
                items.append(currentArticle)
            }
            currentArticle.reset()
        }
        
        if let lastElement = elementStack.last, lastElement != elementName {
            elementStack.append(elementName)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let string = string
            .replacingOccurrences(of: "...", with: "")
            .replacingOccurrences(of: "\n", with: "")
        
        let count = elementStack.count - 1
        
        guard string.isEmpty == false, count > 2 else { return }
        
        let currentElement = elementStack[count]
        
        switch currentElement {
        case "title":
            currentArticle.title += string
        case "description":
            currentArticle.description += string
                .removeAllTags()
                .replacingOccurrences(of: "\n", with: "")
        case "pubDate":
            currentArticle.published = RSS.dateFormatter.date(from: string)
        case "link":
            currentArticle.url += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if let lastElement = elementStack.last, lastElement == elementName {
            elementStack.removeLast()
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        success?(items)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        failure?(parseError)
    }
}
