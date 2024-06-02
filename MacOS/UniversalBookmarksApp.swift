//
//  UniversalBookmarksApp.swift
//  Universal Bookmarks
//
//  Created by James Arnett on 6/2/24.
//

import SwiftUI
import SwiftData

@main
struct UniversalBookmarksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(bookmarkDataContainer)
    }
}
