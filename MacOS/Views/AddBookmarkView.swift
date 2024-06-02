//
//  BookmarkView.swift
//  Simple Universal Bookmarks
//
//  Created by James Arnett on 5/25/24.
//

import SwiftUI
import SwiftData

struct AddBookmarkView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @State private var name = "Apple"
    @State private var url = "https://www.apple.com"
    @State private var selectedBrowser: Browser?
    @State private var showAlert = false
    let browsers: [Browser]
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Bookmark Details").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)) {
                    TextField("Bookmark Name", text: $name)
                    TextField("Bookmark URL", text: $url)
                    Picker("Browser", selection: $selectedBrowser) {
                        ForEach(browsers) { browser in
                            Text(browser.name).tag(browser as Browser?)
                        }
                    }
                }
                Section {
                    Button("Add Bookmark") {
                        guard let browser = selectedBrowser else {
                            showAlert = true
                            return
                        }
                        let newBookmark = Bookmark(name: name, url: url, browser: browser)
                        modelContext.insert(newBookmark)
                        isPresented = false
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


#Preview {
    var browsers: [Browser] = []
    for i in 1..<10 {
        browsers.append(Browser(name: "Safari\(i)", url: URL(string: "file://")!))
    }
    return AddBookmarkView(isPresented: .constant(true), browsers: browsers)
}
