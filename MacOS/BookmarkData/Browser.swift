//
//  Browser.swift
//
//
//  Created by James Arnett on 5/29/24.
//

import Foundation
import SwiftData

@Model
final class Browser {
    var id: String
    var name: String
    var url: URL
    
    init(id: String = UUID().uuidString, name: String, url: URL) {
        self.id = id
        self.name = name
        self.url = url
    }
}
