//
//  EmptyCartView.swift
//  CineGoApp
//
//  Created by beyyzgur on 27.09.2025.
//

import SwiftUI

struct EmptyCartView: View {
    var body: some View {
        VStack(spacing: 140) {
            LottieWrapper(name: "empty_box", loopMode: .loop, speed: 0.5)
                .scaleEffect(0.4)
                .frame(width: 42,height: 42)
                .padding(.horizontal)

            Text("Sepetiniz boş")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 100)
    }
}
