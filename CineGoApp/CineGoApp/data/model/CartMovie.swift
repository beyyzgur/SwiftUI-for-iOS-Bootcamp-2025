//
//  CartMovie.swift
//  CineGoApp
//
//  Created by beyyzgur on 27.09.2025.
//

import Foundation

struct CartMovie: Codable, Identifiable {
    let cartId: Int?
    let name: String?
    let image: String?
    let price: Int?
    let category: String?
    let rating: Double?
    let year: Int?
    let director: String?
    let description: String?
    let orderAmount: Int?
    let userName: String?
    
    var id: Int? { cartId } // identifiable olmuyor bunu koymazsak 
    
    init(cartId: Int?, name: String?, image: String?, price: Int?, category: String?, rating: Double?, year: Int?, director: String?, description: String?, orderAmount: Int?, userName: String?) {
        self.cartId = cartId
        self.name = name
        self.image = image
        self.price = price
        self.category = category
        self.rating = rating
        self.year = year
        self.director = director
        self.description = description
        self.orderAmount = orderAmount
        self.userName = userName
    }
    
}
