//
//  CineGoAppApp.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

import SwiftUI

@main
struct CineGoAppApp: App {
    
    init() {
        URLCache.shared = URLCache(
            memoryCapacity: 100 * 1024 * 1024,
            diskCapacity: 500 * 1024 * 1024,
            diskPath: "cinego-urlcache"
        )
    }
    
    var body: some Scene {
        WindowGroup {
            TabItems()
        }
    }
}
