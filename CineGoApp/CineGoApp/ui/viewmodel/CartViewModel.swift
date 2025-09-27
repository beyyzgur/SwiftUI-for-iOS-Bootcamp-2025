//
//  CartViewModel.swift
//  CineGoApp
//
//  Created by beyyzgur on 27.09.2025.
//
import Foundation


@MainActor
final class CartViewModel: ObservableObject {
    @Published var items: [CartMovie] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let repo = MoviesRepository()
    private let api = APIService()
    
    let userName = "beyyzgur"
    
    func load() {
        isLoading = true
        errorMessage = nil
        Task {
            defer { isLoading = false }
            do {
                // repo üzerinden kullan (api.fetchCart çağırıyor)
                self.items = try await repo.getCart(userName: userName)
                await consolidateDuplicatesOnServerIfNeeded()
            } catch {
                self.errorMessage = error.localizedDescription
                self.items = []
            }
        }
    }
    
    func setQuantity(for item: CartMovie, to newAmount: Int) {
        guard newAmount >= 1 else { return }

        // GEREKLİ ALANLARI KONTROL ET (insertMovie hepsini istiyor)
        guard
            let name = item.name,
            let image = item.image,
            let price = item.price,
            let category = item.category,
            let rating = item.rating,
            let year = item.year,
            let director = item.director,
            let description = item.description
        else {
            self.errorMessage = "Eksik ürün bilgisi (insert için tüm alanlar gerekiyor)."
            return
        }

        Task {
            do {
                // 1) mevcut satırı sil (varsa)
                if let cartId = item.cartId {
                    let del = try await repo.deleteFromCart(cartId: cartId, userName: userName)
                    if del.success != 1 { throw NSError(domain: "Delete", code: -1, userInfo: [NSLocalizedDescriptionKey: del.message ?? "Silme başarısız"]) }
                }

                // 2) yeni adetle ekle
                let movie = Movie(
                    id: nil,
                    name: name,
                    image: image,
                    price: price,
                    category: category,
                    rating: rating,
                    year: year,
                    director: director,
                    description: description
                )
                let ins = try await repo.addToCart(movie: movie, amount: newAmount, userName: userName)
                if ins.success != 1 { throw NSError(domain: "Insert", code: -1, userInfo: [NSLocalizedDescriptionKey: ins.message ?? "Ekleme başarısız"]) }

                await load()
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        Task {
            do {
                for i in offsets {
                    if let cartId = items[i].cartId {
                        let res = try await repo.deleteFromCart(cartId: cartId, userName: userName)
                        if res.success != 1 { throw NSError(domain: "Delete", code: -1, userInfo: [NSLocalizedDescriptionKey: res.message ?? "Silme başarısız"]) }
                    }
                }
                await load()
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func asMovie(_ item: CartMovie) -> Movie {
        Movie(
            id: nil,
            name: item.name,
            image: item.image,
            price: item.price,
            category: item.category,
            rating: item.rating,
            year: item.year,
            director: item.director,
            description: item.description
        )
    }
    
    func imageURL(for item: CartMovie) -> URL? {
        // APIService.fetchImgURL(for:) Movie istiyor; CartMovie'den Movie üret
        let movie = Movie(id: nil,
                          name: item.name,
                          image: item.image,
                          price: item.price,
                          category: item.category,
                          rating: item.rating,
                          year: item.year,
                          director: item.director,
                          description: item.description)
        return api.fetchImgURL(for: movie)
    }
    
    private func consolidateDuplicatesOnServerIfNeeded() async {
        // Grupla: aynı film (name) – istersen name+price ile de gruplayabilirsin
        let groups = Dictionary(grouping: items, by: { ($0.name ?? "").lowercased() })
        for (_, group) in groups where group.count > 1 {
            // Toplam adet
            let total = group.reduce(0) { $0 + ( $1.orderAmount ?? 0 ) }

            // Referans kayıt (alanları dolu olanı seç)
            guard
                let ref = group.first,
                let name = ref.name, let image = ref.image,
                let price = ref.price, let category = ref.category,
                let rating = ref.rating, let year = ref.year,
                let director = ref.director, let description = ref.description
            else { continue }

            // 1) Hepsini sil
            for it in group {
                if let id = it.cartId {
                    _ = try? await repo.deleteFromCart(cartId: id, userName: userName)
                }
            }
            // 2) Tek kaydı toplam adetle ekle
            let movie = Movie(id: nil, name: name, image: image, price: price,
                              category: category, rating: rating, year: year,
                              director: director, description: description)
            _ = try? await repo.addToCart(movie: movie, amount: total, userName: userName)
        }
        // Sunucuyu toparladıktan sonra tekrar çek
        do { self.items = try await repo.getCart(userName: userName) } catch { }
    }

    
    var totalPrice: Int {
        items.reduce(0) { sum, it in
            sum + (it.price ?? 0) * (it.orderAmount ?? 0)
        }
    }
}
