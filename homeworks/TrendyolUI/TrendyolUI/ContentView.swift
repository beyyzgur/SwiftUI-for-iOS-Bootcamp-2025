//
//  ContentView.swift
//  TrendyolUI
//
//  Created by beyyzgur on 12.09.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Anasayfa()
                .tabItem {
                    Image(systemName: "house")
                    Text("Anasayfa")
                }
            Text("Second Tab")
                .tabItem {
                    Image(systemName: "motorcycle")
                    Text("Trendyol Go")
                }
            Text("Third Tab")
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorilerim")
                }
            Text("Fourth Tab")
                .tabItem {
                    Image(systemName: "cart")
                    Text("Sepetim")
                }
            Text("Fifth Tab")
                .tabItem {
                    Image(systemName: "person")
                    Text("Hesabım")
                }
        }
    }
}

#Preview {
    ContentView()
}
