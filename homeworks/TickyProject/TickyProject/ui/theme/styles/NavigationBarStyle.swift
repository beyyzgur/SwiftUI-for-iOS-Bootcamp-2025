//
//  NavigationBarStyle.swift
//  TickyProject
//
//  Created by beyyzgur on 17.09.2025.
//

import Foundation
import SwiftUI

struct NavigationBarStyle {
    static func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(AppColors.mainColor)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(AppColors.white),
            .font: UIFont(name: "oswald", size: 22)!
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(AppColors.white),
            .font: UIFont(name: "oswald", size: 32)!
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
