//
//  NavigationBarStyle.swift
//  ToDosApp
//
//  Created by beyyzgur on 11.09.2025.
//

import Foundation
import SwiftUI

struct NavigationBarStyle {
    static func setupNavigationBarStyle() { // class ismine nokta koyup erişebilmek için static keywordunu ekledim
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
