//
//  CachedAsyncImage.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

// CachedAsyncImage.swift
import SwiftUI

struct CachedAsyncImage: View {
    let url: URL
    @StateObject private var loader = ImageLoader()

    init(url: URL) {
        self.url = url
        _loader = StateObject(wrappedValue: ImageLoader())
    }

    var body: some View {
        ZStack {
            if let ui = loader.image {
                Image(uiImage: ui).resizable().scaledToFill()
            } else {
                ZStack {
                    Rectangle().fill(Color.gray.opacity(0.15))
                    ProgressView()
                }
            }
        }
        .onAppear { loader.load(from: url) }
        .onDisappear { loader.cancel() }
    }
}
