//
//  Model.swift
//  TrendyolUI
//
//  Created by beyyzgur on 16.09.2025.
//

import Foundation

struct PromoBanner: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageName: String? 
}

struct QuickAction: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let systemImage: String
}

struct Product: Identifiable {
    let id = UUID()
    let brand: String
    let title: String
    let price: String
    let rating: Double
    let reviewsCount: Int
    let imageName: String?      
    let isFreeShipping: Bool
    let isSponsored: Bool
}

enum TopCategory: String, CaseIterable, Identifiable {
    case hepsi = "Tüm Kategoriler"
    case kadin = "Kadın"
    case erkek = "Erkek"
    case kozmetik = "Kozmetik"
    case spor = "Spor"
    case superMarket = "Süpermarket"
    var id: String { rawValue }
}
