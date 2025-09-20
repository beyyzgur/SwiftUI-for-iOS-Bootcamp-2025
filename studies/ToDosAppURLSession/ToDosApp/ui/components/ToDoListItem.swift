//
//  ToDoListItem.swift
//  ToDosApp
//
//  Created by Kasım on 9.09.2025.
//

import Foundation
import SwiftUI

struct ToDoListItem : View {
    var toDo = ToDos()
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/toDos/images/\(toDo.image!)"))
            Text(toDo.name!).foregroundStyle(AppColors.textColor)
        }
        .padding(8)
    }
}
