//
//  APIService.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

import Foundation
struct APIService {
    let baseUrl = "http://kasimadalan.pe.hu/movies/"
    
    func fetchAllMovies() async throws -> [Movie] {
        let apiUrl = "\(baseUrl)getAllMovies.php"
        guard let url = URL(string: apiUrl) else {
            throw URLError(.badURL) }
        
        let (data,_) = try await URLSession.shared.data(from: url)
        let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
        
        return moviesResponse.movies
    }
    
    func fetchImgURL(for movie: Movie) -> URL? {
        URL(string: baseUrl + "images/" + (movie.image ?? "dune.png"))
    }
    
    private func formBody(_ params: [String: String]) -> Data? {
            let enc = CharacterSet.urlQueryAllowed
            let joined = params.map { k, v in
                let vv = v.addingPercentEncoding(withAllowedCharacters: enc) ?? ""
                return "\(k)=\(vv)"
            }.joined(separator: "&")
            return joined.data(using: .utf8)
        }
    
    // APIService.swift  (mevcut fetchCart'ı bununla değiştir)
    func fetchCart(userName: String) async throws -> [CartMovie] {
        let apiUrl = "\(baseUrl)getMovieCart.php"
        guard let url = URL(string: apiUrl) else { throw URLError(.badURL) }

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpBody = formBody(["userName": userName])

        let (data, _) = try await URLSession.shared.data(for: req)

        // 1) JSON'u dene
        if let resp = try? JSONDecoder().decode(CartResponse.self, from: data) {
            return resp.movie_cart ?? []          // 👈 null/missing ise []
        }

        // 2) Düz metin/HTML gelirse tolere et (ör: “Required field(s) is missing”)
        let s = String(data: data, encoding: .utf8) ?? ""
        if s.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return [] // boş gövde
        }
        if s.contains("\"movie_cart\":[]") { return [] }
        if s.lowercased().contains("required field") { return [] } // kullanıcı adı yanlışsa vs.

        // 3) Hâlâ anlamadıysak anlaşılır bir hata ver (debug’a yardımcı)
        throw NSError(domain: "FetchCartParse", code: -1,
                      userInfo: [NSLocalizedDescriptionKey: "Sepet yanıtı beklenen formatta değil: \(s.prefix(120))"])
    }

    
    func insertToCart(movie: Movie, orderAmount: Int, userName: String) async throws -> InsertResponse {
            let apiUrl = "\(baseUrl)insertMovie.php"
            guard let url = URL(string: apiUrl) else { throw URLError(.badURL) }

            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            // Elindeki Movie modeli optional; sunucu boş kabul etmesin diye default veriyorum
            let params: [String: String] = [
                "name": movie.name ?? "",
                "image": movie.image ?? "",
                "price": String(movie.price ?? 0),
                "category": movie.category ?? "",
                "rating": String(movie.rating ?? 0),   // Double? güvenli string
                "year": String(movie.year ?? 0),
                "director": movie.director ?? "",
                "description": movie.description ?? "",
                "orderAmount": String(orderAmount),
                "userName": userName
            ]
            req.httpBody = formBody(params)

            let (data, resp) = try await URLSession.shared.data(for: req)
            guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                throw URLError(.badServerResponse)
            }
            return try JSONDecoder().decode(InsertResponse.self, from: data)
        }
    
    // APIService.swift – dosyanın sonuna EKLE (ya da mevcut deleteFromCart'ı bu hale getir)
    // APIService.swift — SONUNA ekle / mevcut deleteFromCart'ı bununla değiştir
    @discardableResult
    func deleteFromCart(cartId: Int, userName: String) async throws -> InsertResponse {
        let apiUrl = "\(baseUrl)deleteMovie.php"
        guard let url = URL(string: apiUrl) else { throw URLError(.badURL) }

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        // bazı backend'ler cartId + userName bekliyor
        let params: [String: String] = [
            "cartId": String(cartId),
            "userName": userName
        ]
        // formBody zaten APIService'te var
        req.httpBody = formBody(params)

        let (data, resp) = try await URLSession.shared.data(for: req)
        guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        // 1) JSON olarak dene
        if let json = try? JSONDecoder().decode(InsertResponse.self, from: data) {
            return json
        }

        // 2) Olmazsa düz metin olarak bak
        let s = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        // ProxyMan'de gördüğün gibi bazen "successfully " metni dönüyor
        if s.contains("\"success\":1") || s.lowercased().contains("successfully") {
            return InsertResponse(success: 1, message: s)
        }
        if s.contains("\"success\":0") {
            return InsertResponse(success: 0, message: s)
        }

        // 3) Hâlâ anlaşılmıyorsa anlaşılır bir hata üret
        throw NSError(domain: "DeleteParse", code: -1,
                      userInfo: [NSLocalizedDescriptionKey: "Delete yanıtı beklenen formatta değil: \(s)"])
    }
}
