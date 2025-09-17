//
//  MainViewModel.swift
//  TickyProject
//
//  Created by beyyzgur on 17.09.2025.
//

import Foundation

@MainActor
class MainViewModel : ObservableObject {
    private let repository = ToDosRepository()
    @Published var toDosList = [ToDos]()
    
    func loadToDos() async {
        do{
            toDosList = try await repository.loadToDos()
        }catch{
            toDosList = [ToDos]()
        }
    }
    
    func search(searchText:String) async {
        do{
            toDosList = try await repository.search(searchText: searchText)
        }catch{
            toDosList = [ToDos]()
        }
    }
    
    func delete(id:Int) async {
        do{
            try await repository.delete(id: id)
            await loadToDos()
        }catch{
            
        }
    }
}
