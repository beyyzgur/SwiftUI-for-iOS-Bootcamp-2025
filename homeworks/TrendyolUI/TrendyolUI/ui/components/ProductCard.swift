//
//  ProductCard.swift
//  TrendyolUI
//
//  Created by beyyzgur on 16.09.2025.
//

import SwiftUI

struct ProductCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
        
                Image(product.imageName!)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(8)

                if product.isSponsored {
                    VStack {
                        HStack {
                            Text("Sponsorlu")
                                .font(.caption2)
                                .foregroundStyle(AppColor.black)
                                .padding(.horizontal, 8).padding(.vertical, 4)
                                .background(AppColor.white.opacity(0.95))
                                .clipShape(Capsule())
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(6)
                }

                if product.isFreeShipping {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Kargo Bedava")
                                .font(.caption2).bold()
                                .foregroundStyle(.white)
                                .padding(.horizontal, 8).padding(.vertical, 4)
                                .background(AppColor.green)
                                .clipShape(Capsule())
                        }
                    }
                    .padding(6)
                }
            }
            
            Text(product.brand)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)

            Text(product.title)
                .font(.subheadline)
                .lineLimit(2)

            HStack(spacing: 4) {
                Image(systemName: "star.fill").font(.caption2)
                Text(String(format: "%.1f", product.rating)).font(.caption)
                Text("(\(product.reviewsCount))").font(.caption)
                Spacer()
            }

            Text(product.price)
                .font(.headline)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12).fill(AppColor.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColor.black.opacity(0.06))
        )
    }
}
