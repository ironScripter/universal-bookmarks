//
//  BookmarksView.swift
//  Simple Universal Bookmarks
//
//  Created by James Arnett on 5/28/24.
//

import SwiftUI

struct BookmarkView: View {
    var bookmark: Bookmark
    var body: some View {
        VStack{
            Spacer()
            Text(bookmark.name)
                .font(.title3)
            Text(bookmark.browser.name)
                .font(.caption)
            Spacer()
        }
        .frame(width: 100, height: 100)
        .background(LinearGradient(gradient: Gradient(colors:[.red, .white, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .foregroundStyle(.black)
    }
}


#Preview {
    BookmarkView(bookmark: Bookmark(name: "Test", url: "https://test.com", browser: Browser(name: "Safari", url: URL(string: "file://")!)))
}
