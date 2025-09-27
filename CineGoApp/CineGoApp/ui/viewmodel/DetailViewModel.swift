//
//  DetailViewModel.swift
//  CineGoApp
//
//  Created by beyyzgur on 27.09.2025.
//

import SwiftUI

@MainActor
final class DetailViewModel: ObservableObject {
    @Published var isPosting = false
    @Published var toast: String?
    
    private let api = APIService()
    let userName = "beyyzgur"
    
    func addToCart(movie: Movie, amount: Int) {
        guard amount >= 1 else { return }
        isPosting = true
           Task {
               defer { isPosting = false }
               do {
                   // insertMovie.php body
                   guard let url = URL(string: api.baseUrl + "insertMovie.php") else { throw URLError(.badURL) }
                   var req = URLRequest(url: url)
                   req.httpMethod = "POST"
                   req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

                   let params: [String: String] = [
                       "name": movie.name ?? "",
                       "image": movie.image ?? "",
                       "price": String(movie.price ?? 0),
                       "category": movie.category ?? "",
                       "rating": String(movie.rating ?? 0),
                       "year": String(movie.year ?? 0),
                       "director": movie.director ?? "",
                       "description": movie.description ?? "",
                       "orderAmount": String(amount),
                       "userName": userName
                   ]
                   let body = params.map { "\($0.key)=\(($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""))" }
                                    .joined(separator: "&")
                   req.httpBody = body.data(using: .utf8)

                   let (data, resp) = try await URLSession.shared.data(for: req)
                   guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                       throw URLError(.badServerResponse)
                   }
                   let res = try JSONDecoder().decode(InsertResponse.self, from: data)
                   if res.success == 1 {
                       showToast("Sepete eklendi ✓")
                   } else {
                       showToast(res.message ?? "Sepete eklenemedi")
                   }
               } catch {
                   showToast(error.localizedDescription)
               }
           }
       }

       private func showToast(_ text: String) {
           toast = text
           DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) { [weak self] in
               self?.toast = nil
           }
       }

       func imageURL(for movie: Movie) -> URL? {
           api.fetchImgURL(for: movie)
       }
}
