//
//  SaveViewModel.swift
//  ToDosApp
//
//  Created by Kasım on 11.09.2025.
//

import Foundation

@MainActor
class SaveViewModel {
    private let repository = ToDosRepository()
    
    func save(name:String,image:String) async {
        do{
            try await repository.save(name: name, image: image)
        }catch{
            //Hata olursa burda kodlama yap
        }
    }
}
