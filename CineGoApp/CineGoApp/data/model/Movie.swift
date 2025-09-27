//
//  Movies.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

import Foundation
struct Movie: Codable, Identifiable {
    let id: Int?
    let name: String?
    let image: String?
    let price: Int?
    let category: String?
    let rating: Double?
    let year: Int?
    let director: String?
    let description: String?
    
    init(id: Int?, name: String?, image: String?, price: Int?, category: String?, rating: Double?, year: Int?, director: String?, description: String?) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.category = category
        self.rating = rating
        self.year = year
        self.director = director
        self.description = description
    }
}

