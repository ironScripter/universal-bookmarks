//
//  BookmarksScrollerView.swift
//  Simple Universal Bookmarks
//
//  Created by James Arnett on 5/28/24.
//

import SwiftUI
import SwiftData

struct BookmarksScrollerView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isEditing: Bool
    @Binding var isLoading: Bool
    @Query private var bookmarks: [Bookmark]
    @Query private var browsers: [Browser]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(bookmarks, id: \.id) { bookmark in
                        Button(action: {
                            let browser = browsers.first {$0.name == bookmark.browser.name}
                            isLoading = true
                            openURLInBrowser(url: bookmark.url, browser: browser!.url){
                                isLoading = false
                            }
                        }) {
                            BookmarkView(bookmark: bookmark)
                        }
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .overlay(
                            isEditing ? Button(action: {
                                if let index = bookmarks.firstIndex(where: { $0.id == bookmark.id }) {
                                    deleteBookmark(offsets: IndexSet(arrayLiteral: index))
                                }
                            })
                            {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            }: nil
                            , alignment: .topTrailing
                        )
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {
                                if let index = bookmarks.firstIndex(where: { $0.id == bookmark.id }) {
                                    deleteBookmark(offsets: IndexSet(arrayLiteral: index))
                                }
                            }) {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }))
                    }
            }
            .frame(minWidth: 325, minHeight: 200)
            .padding()
        }
    }
    private func deleteBookmark(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(bookmarks[index])
            }
        }
    }
}
