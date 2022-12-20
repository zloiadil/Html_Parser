//
//  HTMLParser.swift
//  HTMLParser
//
//  Created by Адиль Бектурсунов on 20.12.2022.
//

import SwiftSoup
import Foundation

final class HTMLParser {
    func parse(html: String) {
        do {
            let document: Document = try SwiftSoup.parse(html)
            guard let body = document.body() else {
                return
            }
            let headers: [String] = try body.getElementsByTag("h3").compactMap({
                try? $0.html()
            })
            print(headers)
        }
        catch {
            print("Error Parsing: " + String(describing: error))
        }
    }
}
