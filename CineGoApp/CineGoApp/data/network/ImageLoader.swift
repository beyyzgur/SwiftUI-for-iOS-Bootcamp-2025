//
//  ImageLoader.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

import UIKit

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var task: Task<Void, Never>?

    func load(from url: URL) {
        // 1) NSCache’te varsa direkt ver
        if let cached = ImageMemoryCache.shared.cache.object(forKey: url as NSURL) {
            self.image = cached
            return
        }

        // 2) Yoksa indir (HTTP cache: returnCacheDataElseLoad)
        task?.cancel()
        task = Task {
            do {
                var req = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
                let (data, _) = try await URLSession.shared.data(for: req)
                if let img = UIImage(data: data) {
                    ImageMemoryCache.shared.cache.setObject(img, forKey: url as NSURL)
                    self.image = img
                }
            } catch {
                // İstersen burada hata durumunu logla
            }
        }
    }

    func cancel() { task?.cancel() }
}
