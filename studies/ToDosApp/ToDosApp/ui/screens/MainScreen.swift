//
//  MainScreen.swift
//  ToDosApp
//
//  Created by beyyzgur on 4.09.2025.
//

import SwiftUI

// for VSTACK -->> left -> leading, right -> trailing
// maxWidth: .infinity, maxHeight: .infinity -->> Bulunduğun alan kadar yayıl.

struct MainScreen: View {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(AppColors.mainColor)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(AppColors.whiteColor)]
        appearance.titleTextAttributes = [.foregroundColor: UIColor(AppColors.whiteColor)]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        // bütün sayfaların navbar arka plan renginin aynı olması için bunu init() içerisinde tanımladım.
    }
    
    var body: some View {
        NavigationStack { // Sayfa geçişi ve sayfa başlığı için koymak istedim bunu
            VStack {
               Text("Hello girrrrl")
            }
            .navigationTitle("ToDos") // title i navStack'in çevrelediği ilk yapıya vermeliyim
        }
    }
}

#Preview {
    MainScreen()
}
