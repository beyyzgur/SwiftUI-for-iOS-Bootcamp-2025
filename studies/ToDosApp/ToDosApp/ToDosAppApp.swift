//
//  ToDosAppApp.swift
//  ToDosApp
//
//  Created by beyyzgur on 4.09.2025.
//

// Uygulamanın ana dosyası - genel kurulumlar, genel ayarlar burada yapılırç

import SwiftUI

@main  // app çalışmaya başladığı zaman ilk çalışan kodlar bu kodlardır.
struct ToDosAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(\.font, .custom("oswald", size: 18))
        }
    }
}
