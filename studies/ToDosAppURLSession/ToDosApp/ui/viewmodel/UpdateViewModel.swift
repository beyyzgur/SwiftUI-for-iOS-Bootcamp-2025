//
//  UpdateViewModel.swift
//  ToDosApp
//
//  Created by Kasım on 11.09.2025.
//

import Foundation

@MainActor
class UpdateViewModel {
    private let repository = ToDosRepository()
    
    func update(id:Int,name:String) async {
        do {
            try await repository.update(id: id, name: name)
        }catch{
            
        }
    }
}
