//
//  RoundIconButton.swift
//  TrendyolUI
//
//  Created by beyyzgur on 16.09.2025.
//

import SwiftUI

struct RoundIconButton: View {
    let systemName: String
    var badge: Int? = nil
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                // ikon + daire tam ortalı
                Image(systemName: systemName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppColor.black.opacity(0.9))
                    .frame(width: 36, height: 36)   // kare alan
                    .background(
                        Circle()
                            .fill(Color(.systemBackground))
                            .overlay(
                                Circle().stroke(Color.black.opacity(0.08), lineWidth: 1)
                            )
                    )
                    .shadow(color: .black.opacity(0.06), radius: 6, y: 2)

                if let badge, badge > 0 {
                    Text(badge > 9 ? "9+" : "\(badge)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 4).padding(.vertical, 1)
                        .background(AppColor.red)
                        .clipShape(Capsule())
                        .offset(x: 4, y: -4)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
