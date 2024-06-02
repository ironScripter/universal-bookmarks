//
//  Bookmark.swift
//
//
//  Created by James Arnett on 5/29/24.
//

import Foundation
import Observation
import SwiftData

@Model
final class Bookmark {
    var id: String
    var created: Date
    var name: String
    var url: String
    var browser: Browser
    
    init(id: String = UUID().uuidString, name: String, url: String, browser: Browser) {
        self.id = id
        self.created = Date()
        self.name = name
        self.url = url
        self.browser = browser
    }
}
