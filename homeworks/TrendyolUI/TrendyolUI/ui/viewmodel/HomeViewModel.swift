//
//  HomeViewModel.swift
//  TrendyolUI
//
//  Created by beyyzgur on 16.09.2025.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedCategory: TopCategory = .kadin
    @Published var banners: [PromoBanner] = []
    @Published var actions: [QuickAction] = []
    @Published var products: [Product] = []

    init() { loadMock() }

    private func loadMock() {
        banners = [
            PromoBanner(title: "iPhone 17 Pro", subtitle: "19 Eylül 08.00'da Sizinle!", imageName: "iphone17pro"),
            .init(title: "Trendyol Plus", subtitle: "Özel Fiyatlar", imageName: nil)
        ]
        actions = [
            .init(title: "Yemek", subtitle: "81 İLDE", systemImage: "fork.knife"),
            .init(title: "Hızlı Market", subtitle: "30 DK!", systemImage: "cart.badge.clock"),
            .init(title: "Evliliğe Destek", subtitle: "Kampanya", systemImage: "sparkles"),
            .init(title: "Sanat Eserleri", subtitle: "Trendyol Sanat", systemImage: "paintpalette"),
            .init(title: "Süt", subtitle: "%", systemImage: "drop")
        ]
        products = [
            Product(
                brand: "Beyyzgur Collection",
                title: "Yandan Bağlamalı Kadın Yazlık Etek",
                price: "409 TL",
                rating: 4.4,
                reviewsCount: 1734,
                imageName: "lilaEtek",
                isFreeShipping: true,
                isSponsored: false
            ),
            Product(
                brand: "Zara",
                title: "Şık Topuklu Ayakkabı Bağcıklı",
                price: "1250 TL",
                rating: 4.7,
                reviewsCount: 240,
                imageName: "topukluAyakkabı",
                isFreeShipping: false,
                isSponsored: true
            ),
            Product(
                brand: "Nioli",
                title: "Doğal Nioli Yağı 30ml",
                price: "249 TL",
                rating: 4.2,
                reviewsCount: 312,
                imageName: "nioliYagı",
                isFreeShipping: false,
                isSponsored: true
            )
        ]
    }
}
