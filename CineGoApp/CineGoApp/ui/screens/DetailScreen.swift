//
//  DetailScreen.swift
//  CineGoApp
//
//  Created by beyyzgur on 27.09.2025.
//

import SwiftUI

struct DetailScreen: View {
    let movie: Movie
    @StateObject private var vm = DetailViewModel()
    @State private var quantity = 1
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                if let url = vm.imageURL(for: movie) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                Rectangle().fill(Color.gray.opacity(0.15))
                                ProgressView()
                            }
                        case .success(let img):
                            img.resizable().scaledToFill()
                        case .failure:
                            ZStack {
                                Rectangle().fill(Color.gray.opacity(0.15))
                                Image(systemName: "photo")
                            }
                        @unknown default:
                            Color.clear
                        }
                    }
                    .frame(height: 280)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                Text(movie.name ?? "—")
                    .font(.title).bold()
                Text("\(movie.category ?? "—") • \(String(format: "%d", movie.year ?? 0))")
                    .foregroundStyle(.secondary)
                HStack(spacing: 12) {
                    Text("⭐️ \(String(format: "%.1f", movie.rating!))")
                    Text("\(movie.price ?? 0) ₺")
                }
                .foregroundStyle(.secondary)
                
                Text(movie.description ?? "")
                    .font(.body)
                
                // Adet seçimi (min 1)
                HStack {
                    Text("Adet")
                    Spacer()
                    Stepper(value: $quantity, in: 1...99) {
                        Text("\(quantity)").monospacedDigit()
                    }
                    .frame(maxWidth: 180)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Button {
                    vm.addToCart(movie: movie, amount: quantity)
                } label: {
                    HStack {
                        Image(systemName: "cart.badge.plus")
                        Text(vm.isPosting ? "Ekleniyor…" : "Sepete Ekle (\(quantity))")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                           .clipShape(RoundedRectangle(cornerRadius: 12))
                       }
                       .disabled(vm.isPosting)
                   }
                   .padding()
               }
               .navigationTitle("Detay")
               .navigationBarTitleDisplayMode(.inline)
               .overlay(alignment: .top) {
                   if let t = vm.toast {
                       Text(t)
                           .padding(.horizontal, 16)
                           .padding(.vertical, 10)
                           .background(.ultraThinMaterial)
                           .clipShape(Capsule())
                           .padding(.top, 12)
                           .transition(.move(edge: .top).combined(with: .opacity))
                           .animation(.easeInOut, value: vm.toast)
                   }
               }
           }
    }
