//
//  BookmarkDataContainer.swift
//  
//
//  Created by James Arnett on 5/31/24.
//

import SwiftUI
import SwiftData

//struct BookmarkDataContainerViewModifier: ViewModifier {
//    let container: ModelContainer
//    let schema = Schema([
//        Bookmark.self,
//        Browser.self
//    ])
//    init(inMemory: Bool) {
//        container = try! ModelContainer(for: schema, configurations: [ModelConfiguration(isStoredInMemoryOnly: inMemory)])
//    }
//    
//    func body(content: Content) -> some View {
//        content
//            .modelContainer(container)
//    }
//}
//
//extension View {
//    func bookmarkDataContainer(inMemory: Bool = false) -> some View {
//        modifier(BookmarkDataContainerViewModifier(inMemory: inMemory))
//    }
//}


var bookmarkDataContainer: ModelContainer = {
    let schema =  Schema([
        Bookmark.self,
        Browser.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()
