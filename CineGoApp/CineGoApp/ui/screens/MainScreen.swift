//
//  ContentView.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

import SwiftUI

struct MainScreen: View {
    @StateObject private var vm = MoviesViewModel()
    
    private let repo = MoviesRepository()
    private let columns = [GridItem(.adaptive(minimum: 140), spacing: 12)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(vm.movies) { m in
                        NavigationLink {
                            DetailScreen(movie: m)   // 👉 hedefti bu
                        } label: {
                            MovieCard(movie: m, imageURL: repo.getImage(for: m)!)
                        }
                        .buttonStyle(.plain)               // kart içindeki buton/gesture’lar link’i engellemesin
                        .contentShape(Rectangle())
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)
            }
            .navigationTitle("CineGo")
            .overlay {
                if vm.isLoading { ProgressView("Yükleniyor...") }
            }
            .task { vm.load() }
            .alert("Hata", isPresented: .constant(vm.errorMessage != nil)) {
                Button("Tamam") { vm.errorMessage = nil }
            } message: {
                Text(vm.errorMessage ?? "")
            }
            .refreshable { vm.load() } // aşağı çek yenile
        }
    }
}

#Preview {
    MainScreen()
}
