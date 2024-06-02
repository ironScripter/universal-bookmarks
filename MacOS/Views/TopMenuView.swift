//
//  TopMenuView.swift
//  Simple Universal Bookmarks
//
//  Created by James Arnett on 5/28/24.
//

import SwiftUI
import SwiftData


struct TopMenuView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isAddBookmarkViewPresented: Bool
    @Binding var isEditing: Bool
    let bookmarks: [Bookmark]
    let browsers: [Browser]
    
    var body: some View {
        Spacer()
        HStack {
            Button(action: {
                self.isAddBookmarkViewPresented.toggle()
            }) {
                Label("Add Bookmark", systemImage: "plus")
            }
            .sheet(isPresented: $isAddBookmarkViewPresented) {
                AddBookmarkView(
                    isPresented: $isAddBookmarkViewPresented,
                    browsers: browsers
                )
                    .modelContainer(modelContext.container)
            }
            Button(action: {
                isEditing.toggle()
            }) {
                if isEditing {
                    Text("Done")
                } else {
                    Text("Edit")
                }
            }
            .frame(alignment: .topTrailing)
        }
    }
}
