//
//  SaveScreen.swift
//  ToDosApp
//
//  Created by beyyzgur on 6.09.2025.
//

import SwiftUI

struct SaveScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var randomImage = ""
    @State private var nameController = ""
    @State private var showError = false
    
    func save(name: String, image: String) {
        print("ToDos Save Function: \(name) & \(image)")
    }
    
    var body: some View {
        VStack(spacing: 32) {
            Image(randomImage)
            
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
                    save(name: nameController, image: randomImage)
                    dismiss()
                }
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(AppColors.mainColor)
                    .foregroundStyle(AppColors.whiteColor)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationTitle("Save ToDos")
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
        .onAppear() {
            let images = ["agac", "araba", "cicek", "damla", "gezegen", "günes", "roket", "semsiye", "yildiz"]
            randomImage = images.randomElement() ?? "agac"
        }
    }
}

//#Preview {
//    SaveScreen()
//}
