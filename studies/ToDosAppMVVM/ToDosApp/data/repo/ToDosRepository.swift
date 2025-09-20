//
//  ToDosRepository.swift
//  ToDosApp
//
//  Created by beyyzgur on 11.09.2025.
//

import Foundation

class ToDosRepository {
    func save(name:String,image:String) async throws { // bu fonksiyon hata fırlatabilir, fakat try catch i view model de kullanacaksın cunku veri orda gönderiliyor
        print("ToDo Save : \(name) - \(image)")
    }
    
    func update(id:Int,name:String) async throws {
        print("ToDo Update : \(id) - \(name)")
    }
    
    func delete(id: Int) async throws {
        print("todos delete - repository: \(id)")
    }
    
    func loadToDos() async throws -> [ToDos] {
        var list = [ToDos]()
        let toDo1 = ToDos(id: 1, name: "Buy a plane ticket", image: "roket")
        let toDo2 = ToDos(id: 2, name: "Join the meeting", image: "damla")
        let toDo3 = ToDos(id: 3, name: "Go to gym", image: "simsek")
        list.append(toDo1)
        list.append(toDo2)
        list.append(toDo3)
        
        return list
    }
    
    func search(searchText: String) async throws -> [ToDos] {
        let allToDos = try await loadToDos()
        
        if searchText.isEmpty {
            return allToDos
        }
        
        return allToDos.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
    }
}
