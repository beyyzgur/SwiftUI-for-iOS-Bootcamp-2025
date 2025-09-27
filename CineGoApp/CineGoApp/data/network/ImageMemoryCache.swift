//
//  ImageMemoryCache.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

import UIKit

final class ImageMemoryCache {
    static let shared = ImageMemoryCache()
    let cache = NSCache<NSURL, UIImage>()
    private init() { cache.countLimit = 500 } // en fazla 500 görsel (örnek)
}
