//
//  TopNavBar.swift
//  TrendyolUI
//
//  Created by beyyzgur on 16.09.2025.
//

import SwiftUI

struct TopNavBar: View {
    @Binding var search: String
    @Binding var selectedCategory: TopCategory

    var body: some View {
        ZStack(alignment: .bottom) {
            AppColor.navBarColor.ignoresSafeArea()

            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    TYSearchBar(text: $search)
                        .frame(maxWidth: .infinity)

                    HStack(spacing: 8) {
                        RoundIconButton(systemName: "envelope", badge: 4) {}
                        RoundIconButton(systemName: "bell", badge: 9) {}
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 6)
                .padding(.bottom, 2)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(TopCategory.allCases) { cat in
                            let isSelected = (selectedCategory == cat)
                            Button {
                                selectedCategory = cat
                            } label: {
                                Text(cat.rawValue)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(isSelected ? AppColor.trendyolTuruncusu : AppColor.black.opacity(0.85))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(
                                        Capsule().fill(isSelected
                                                       ? AppColor.white
                                                       : Color(.secondarySystemBackground))
                                    )
                                    .overlay(
                                        Capsule()
                                            .stroke(isSelected ? AppColor.trendyolTuruncusu.opacity(0.18) : .clear, lineWidth: 1)
                                    )
                                    .shadow(color: isSelected ? .black.opacity(0.06) : .clear, radius: 8, y: 2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 8)
            }
        }
        .frame(height: 140)
    }
}
