//
//  QuickActionPills.swift
//  TrendyolUI
//
//  Created by beyyzgur on 16.09.2025.
//

import SwiftUI

struct QuickActionPills: View {
    let items: [QuickAction]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(items) { it in
                    VStack(spacing: 8) {
                        ZStack {
                            Circle().fill(Color(.secondarySystemBackground))
                                .frame(width: 64, height: 64)
                            Image(systemName: it.systemImage).font(.title2)
                        }
                        VStack(spacing: 0) {
                            if let sub = it.subtitle {
                                Text(sub).font(.caption2).foregroundStyle(AppColor.yellow)
                            }
                            Text(it.title).font(.footnote).foregroundStyle(AppColor.textColor)
                        }
                    }
                }
            }
            .padding(.horizontal, UIConst.padding)
        }
    }
}
