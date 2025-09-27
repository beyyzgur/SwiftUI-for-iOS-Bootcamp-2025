//
//  CartResponse.swift
//  CineGoApp
//
//  Created by beyyzgur on 27.09.2025.
//

import Foundation
struct CartResponse: Codable {
    let movie_cart: [CartMovie]?
    
    enum CodingKeys: String, CodingKey {
        case movie_cart = "movie_cart"
    }
}
