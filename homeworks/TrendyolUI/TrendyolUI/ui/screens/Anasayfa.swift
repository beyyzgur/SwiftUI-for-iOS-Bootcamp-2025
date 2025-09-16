//
//  Anasayfa.swift
//  TrendyolUI
//
//  Created by beyyzgur on 12.09.2025.
//

import SwiftUI

struct Anasayfa: View {
    @StateObject private var vm = HomeViewModel()

    var body: some View {
        ZStack {
            AppColor.white.ignoresSafeArea()

            VStack(spacing: 0) {
                TopNavBar(search: $vm.searchText,
                          selectedCategory: $vm.selectedCategory)

                ScrollView {
                    VStack(spacing: 16) {
                        BannerCarousel(items: vm.banners)
                        QuickActionPills(items: vm.actions)

                        HStack {
                            Text("Sana Özel Ürünler").font(.title3).bold()
                            Spacer()
                            Button("Tümünü Gör >") {}
                                .font(.subheadline)
                                .foregroundStyle(AppColor.trendyolTuruncusu)
                        }
                        .padding(.horizontal, 16)

                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 12),
                                            GridItem(.flexible(), spacing: 12)],
                                  spacing: 12) {
                            ForEach(vm.products) { p in
                                ProductCard(product: p)
                                    .frame(maxHeight: 320)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
    }
}

#Preview { Anasayfa() }
