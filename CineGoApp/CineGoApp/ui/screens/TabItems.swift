//
//  TabItems.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

import SwiftUI

struct TabItems: View {
    var body: some View {
            TabView {
                MainScreen()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Anasayfa")
                    }
                CardScreen()
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Sepetim")
                    }
            }
            .accentColor(.indigo)
    }
}

#Preview {
    TabItems()
}
