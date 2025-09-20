//
//  SaveScreen.swift
//  ToDosApp
//
//  Created by Kasım on 6.09.2025.
//

import SwiftUI

struct SaveScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var randomImage = ""
    @State private var nameController = ""
    @State private var showError = false
    var viewModel = SaveViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            AsyncImage(url: URL(string: "http://kasimadalan.pe.hu/toDos/images/\(randomImage)"))
            
            TextField("Name",text: $nameController).textFieldStyle(CustomTextfieldStyle())
            
            if showError {
                Text("Name can not be empty !").foregroundStyle(AppColors.red)
            }
            
            Button{
                if nameController.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    showError = true
                }else{
                    showError = false
                    Task {
                        await viewModel.save(name: nameController, image: randomImage)
                    }
                    dismiss()
                }
            }label: {
                Text("Save").frame(maxWidth: .infinity)
            }.buttonStyle(CustomButtonStyle())
        }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .padding()
        .navigationTitle("Save Screen")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.backward").foregroundColor(AppColors.white)
                            Text("ToDos").foregroundColor(AppColors.white)
                        }
                    }
                }
            }.onAppear(){
                let images = ["agac.png","araba.png","cicek.png","damla.png","gezegen.png","gunes.png","roket.png","semsiye.png","yildiz.png"]
                randomImage = images.randomElement() ?? "agac.png"
            }
    }
}

#Preview {
    SaveScreen()
}
