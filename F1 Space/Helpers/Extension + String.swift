//
//  Extension + String.swift
//  F1 Space
//
//  Created by Nikita Sukachev on 29.07.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

extension String {
    func removeAllTags() -> String {
        let data = Data(utf8)
        if let attributedString = try? NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                                          documentAttributes: nil) {
            return attributedString.string
        } else {
            return self
        }
    }
}
