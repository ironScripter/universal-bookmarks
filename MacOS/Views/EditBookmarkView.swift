//
//  EditBookmarkView.swift
//  Simple Universal Bookmarks
//
//  Created by James Arnett on 5/27/24.
//

import SwiftUI

struct EditBookmarkView: View {
    @Binding var isPresented: Bool
    @State private var name = "Apple"
    @State private var url = "https://www.apple.com"
    @State private var selectedBrowser: Browser?
    @State private var showAlert = false
    @Binding var bookmark: Bookmark
    var browsers: [Browser]
    var editBookmarkAction: (Bookmark) -> Void // Closure to add a bookmark
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Bookmark Details").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)) {
                    TextField("Bookmark Name", text: $bookmark.name)
                    TextField("Bookmark URL", text: $bookmark.url)
                    Picker("Browser", selection: $bookmark.browser) {
                        ForEach(browsers) { browser in
                            Text(browser.name).tag(browser.name)
                        }
                    }
                }
                Section {
                    HStack {
                        Button("Save Changes?") {
                            editBookmarkAction(
                                Bookmark(
                                    name: bookmark.name,
                                    url: bookmark.url,
                                    browser: bookmark.browser
                                )
                            )
                            isPresented = false
                        }
                        Button("Cancel") {
                            isPresented = false
                        }
                    }
                }
                
            }
            .navigationTitle("Add Bookmark")
            .padding()
        }
        .frame(minWidth: 300, minHeight: 200)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("No Broswer Selected"), message: Text("Please select a browser"), dismissButton: .default(Text("OK")))
        }
    }
}


struct EditBookmarkView_Preview: PreviewProvider {
    static var previews: some View {
        EditBookmarkView(
            isPresented: .constant(true),
            bookmark: Binding.constant(Bookmark(
                name: "Existing",
                url: "https://Existing.com",
                browser: Browser(name: "Safari", url: URL(string: "file://")!)
            )),
            browsers: [
                Browser(name: "Safari", url: URL(string: "file://")!),
                Browser(name: "Google Chrome", url: URL(string: "file://")!),
                Browser(name: "Firefox", url: URL(string: "file://")!)
            ], 
            editBookmarkAction: { bookmark in
                // Add bookmark action implementation
                print("Adding bookmark: \(bookmark)")
            }
        )
    }
}
