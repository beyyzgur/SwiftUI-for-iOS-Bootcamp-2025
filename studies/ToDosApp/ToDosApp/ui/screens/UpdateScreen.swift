//
//  DetailScreen.swift
//  ToDosApp
//
//  Created by beyyzgur on 6.09.2025.
//

import SwiftUI

struct UpdateScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var nameController = ""
    @State private var showError = false
    
    var toDo = ToDos()
    
    func update(id: Int, name: String) {
        print("ToDos Save Function: \(id) & \(name)")
    }
    
    var body: some View {
        VStack(spacing: 32) {
            Image(toDo.image ?? "agac")
            
            TextField("Name", text: $nameController)
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(AppColors.mainColor,lineWidth: 1))
            
            if showError {
                Text("Name cannot be empty!")
                    .foregroundStyle(AppColors.redColor)
            }
            
            Button {
                if nameController.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    showError = true
                } else {
                    showError = false
                    if let id = toDo.id {
                        update(id: id, name: nameController)
                    }
                    dismiss()
                }
            } label: {
                Text("Update")
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(AppColors.mainColor)
                    .foregroundStyle(AppColors.whiteColor)
                    .cornerRadius(8)
            }
        }
        .padding() // ???????????????????????
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Update ToDos")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(AppColors.whiteColor)
                        
                        Text("ToDos")
                            .foregroundColor(AppColors.whiteColor)
                    }
                }
            }
        }
        .onAppear {
            if let name = toDo.name {
                nameController = name
            }
        }
    }
}

//#Preview {
//    UpdateScreen()
//}
