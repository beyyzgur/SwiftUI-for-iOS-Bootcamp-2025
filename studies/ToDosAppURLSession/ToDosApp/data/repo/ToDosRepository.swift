//
//  ToDosRepository.swift
//  ToDosApp
//
//  Created by Kasım on 11.09.2025.
//

import Foundation

class ToDosRepository {
    
    /// http://kasimadalan.pe.hu/toDos/getAllToDos.php
    
    private let baseURL = "http://kasimadalan.pe.hu/toDos/"
    
    func save(name:String,image:String) async throws {
        let apiURL = "\(baseURL)insert.php"
        guard let url = URL(string: apiURL) else {
            throw URLError(.badURL) // fonksiyon async await old için return yerine throw da kullanabiliriz
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "name=\(name)&image=\(image)"
        request.httpBody = postString.data(using: .utf8)
        
        let (data,_) = try await URLSession.shared.data(for: request)
        let crudResponse = try JSONDecoder().decode(CRUDResponse.self, from: data)
        print("Response : \(crudResponse.success!) - \(crudResponse.message!)")
    }
    
    func update(id:Int,name:String) async throws {
        let apiURL = "\(baseURL)update.php"
        guard let url = URL(string: apiURL) else {
            throw URLError(.badURL) // fonksiyon async await old için return yerine throw da kullanabiliriz
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "id=\(id)&name=\(name)"
        request.httpBody = postString.data(using: .utf8)
        
        let (data,_) = try await URLSession.shared.data(for: request)
        let crudResponse = try JSONDecoder().decode(CRUDResponse.self, from: data)
        print("Response : \(crudResponse.success!) - \(crudResponse.message!)")
    }
    
    func delete(id:Int) async throws {
        let apiURL = "\(baseURL)delete.php"
        guard let url = URL(string: apiURL) else {
            throw URLError(.badURL) // fonksiyon async await old için return yerine throw da kullanabiliriz
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "id=\(id)"
        request.httpBody = postString.data(using: .utf8)
        
        let (data,_) = try await URLSession.shared.data(for: request)
        let crudResponse = try JSONDecoder().decode(CRUDResponse.self, from: data)
        print("Response : \(crudResponse.success!) - \(crudResponse.message!)")
    }
    
    func loadToDos() async throws -> [ToDos] {
        let apiURL = "\(baseURL)getAllToDos.php"
        guard let url = URL(string: apiURL) else {
            throw URLError(.badURL) // fonksiyon async await old için return yerine throw da kullanabiliriz
        }
        
        let (data,_) = try await URLSession.shared.data(from: url)
        let toDosResponse = try JSONDecoder().decode(ToDosResponse.self, from: data)
        
        return toDosResponse.toDos!
    }
    
    func search(searchText:String) async throws -> [ToDos] {
//        let allToDos = try await loadToDos()
//        
//        if searchText.isEmpty {
//            return allToDos
//        }
//        
//        return allToDos.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
        
        
        let apiURL = "\(baseURL)search.php"
        guard let url = URL(string: apiURL) else {
            throw URLError(.badURL) // fonksiyon async await old için return yerine throw da kullanabiliriz
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "name=\(searchText)"
        request.httpBody = postString.data(using: .utf8)
        
        let (data,_) = try await URLSession.shared.data(for: request)
        let toDosResponse = try JSONDecoder().decode(ToDosResponse.self, from: data)
        
        return toDosResponse.toDos!
    }
}
