//
//  SaveViewModel.swift
//  TickyProject
//
//  Created by beyyzgur on 17.09.2025.
//

import Foundation

@MainActor
class SaveViewModel {
    private let repository = ToDosRepository()
    
    func save(name:String) async {
        do{
            try await repository.save(name: name)
        }catch{
            print(error.localizedDescription)
        }
    }
}
