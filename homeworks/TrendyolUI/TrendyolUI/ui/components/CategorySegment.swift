//
//  CategorySegment.swift
//  TrendyolUI
//
//  Created by beyyzgur on 16.09.2025.
//

import SwiftUI

struct CategorySegment: View {
    @Binding var selection: TopCategory

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(TopCategory.allCases) { cat in
                    let isSelected = (selection == cat)
                    Button {
                        selection = cat
                    } label: {
                        Text(cat.rawValue)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(isSelected ? AppColor.trendyolTuruncusu : AppColor.black.opacity(0.8))
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
    }
}
