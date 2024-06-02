//
//  ContentView.swift
//  Simple Universal Bookmarks
//
//  Created by James Arnett on 5/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isAddBookmarkViewPresented = false
    @State private var selectedBookmarkIndex: Int?
    @State private var isEditing = false
    @State private var isLoading = false
    @Query var bookmarks: [Bookmark]
    @Query var browsers: [Browser]
    @State private var initialBrowsers: [Browser] = []
    
    var body: some View {
            VStack {
                TopMenuView(
                    isAddBookmarkViewPresented: $isAddBookmarkViewPresented,
                    isEditing: $isEditing,
                    bookmarks: bookmarks,
                    browsers: initialBrowsers
                )
                .modelContext(modelContext)
                BookmarksScrollerView(isEditing: $isEditing, isLoading: $isLoading)
                    .modelContext(modelContext)
            }
            .overlay(content: {
                if isLoading {
                    LoadingView()
                }
            })
            .onAppear {
                initialBrowsers = getInstalledBrowsers()
            }
            .navigationTitle("Simple Universal Bookmarks")
            .frame(minWidth: 400, minHeight: 600)
            .background(RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 1, endRadius: 400))
        }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Bookmark.self, configurations: config)

        for i in 1..<10 {
            let bookmark = Bookmark(
                name: "Bookmark\(i)",
                url: "https://example.com",
                browser: Browser(
                    name: "Safari",
                    url: URL(string: "file://")!
                )
            )
            container.mainContext.insert(bookmark)
        }
    
    return ContentView()
        .modelContainer(container)
}
