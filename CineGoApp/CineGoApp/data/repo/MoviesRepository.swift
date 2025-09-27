//
//  MoviesRepository.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

import Foundation
class MoviesRepository {
    private let api = APIService()
    
    func getAllMovies() async throws -> [Movie] {
        try await api.fetchAllMovies()
    }
    
    func getImage(for movie: Movie) -> URL? {
        api.fetchImgURL(for: movie)
    }
    
    func getCart(userName: String) async throws -> [CartMovie] {
        try await api.fetchCart(userName: userName)
    }
    
    @discardableResult
    func addToCart(movie: Movie, amount: Int, userName: String) async throws -> InsertResponse {
        try await api.insertToCart(movie: movie, orderAmount: amount, userName: userName)
    }
    
    @discardableResult
    func deleteFromCart(cartId: Int, userName: String) async throws -> InsertResponse {
        try await api.deleteFromCart(cartId: cartId, userName: userName)
    }

}
