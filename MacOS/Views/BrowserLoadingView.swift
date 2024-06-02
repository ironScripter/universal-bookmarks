//
//  BrowserLoadingView.swift
//  Universal Bookmarks
//
//  Created by James Arnett on 6/2/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            Spacer()
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .font(.largeTitle)
            Spacer()
        }
    }
}
