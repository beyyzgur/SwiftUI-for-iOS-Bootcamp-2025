//
//  SaveViewModel.swift
//  ToDosApp
//
//  Created by beyyzgur on 11.09.2025.
//

import Foundation

@MainActor // --> DispachQueue --> çünkü UILayer
class SaveViewModel {
    private let repository = ToDosRepository()
    
    func save(name:String,image:String) async { // bu fonksiyon hata fırlatabilir, fakat try catch i view model de kullanacaksın cunku veri orda gönderiliyor
        do {
           try await repository.save(name: name, image: image)
        } catch {
            // error kodları
        }
    }
}
