//
//  MainScreen.swift
//  ToDosApp
//
//  Created by Kasım on 4.09.2025.
//

import SwiftUI

//left - start - leading
//right - end - trailing
//maxWidth: .infinity,maxHeight: .infinity -> match parent - match constraint (Bulunduğu alan kadar yayıl)

struct MainScreen: View {
    
    init(){
        NavigationBarStyle.setupNavigationBar()
        DatabaseHelper.copyDatabase()
    }
    
    @State private var searchText = ""
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.toDosList.isEmpty {
                    Text("No ToDos Yet !").foregroundStyle(AppColors.textColor)
                }else{
                    List{
                        ForEach(viewModel.toDosList){ toDo in
                            NavigationLink(destination: UpdateScreen(toDo : toDo)){
                                ToDoListItem(toDo: toDo)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("ToDos")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: SaveScreen()){
                        Image(systemName: "plus").foregroundColor(AppColors.white)
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadToDos()
                }
            }
        }
        .tint(AppColors.white)
        .searchable(text: $searchText,prompt: "Search")
        .onChange(of: searchText){ _,result in
            Task{
                await viewModel.search(searchText: result)
            }
        }
    }
    
    func delete(at offsets: IndexSet){
        let toDo = viewModel.toDosList[offsets.first!]
        Task {
            await viewModel.delete(id: toDo.id!)
        }
    }
}

#Preview {
    MainScreen()
}

