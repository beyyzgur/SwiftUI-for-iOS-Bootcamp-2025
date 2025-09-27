//
//  MovieCard.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    let imageURL: URL
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            let yearString = String(format: "%d", movie.year ?? 0)
            // phase tabanlı AsyncImage -> failure durumunu da ele alıyoruz
            CachedAsyncImage(url: imageURL)
                .frame(height: 200)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(movie.name!)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("\(movie.category!) • \(yearString)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack {
                    Text("⭐️ \(String(format: "%.1f", movie.rating!))")
                    Spacer()
                    Text("\(movie.price!) ₺")
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
            .padding(10)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 2, y: 1)
        }
    }
