//
//  CardScreen.swift
//  CineGoApp
//
//  Created by beyyzgur on 26.09.2025.
//

import SwiftUI

struct CardScreen: View {
    @StateObject private var vm = CartViewModel()
    
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView("Yükleniyor…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if vm.items.isEmpty {
                    EmptyCartView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                    VStack(spacing: 12) {
//                        Image(systemName: "cart")
//                            .font(.system(size: 44))
//                            .foregroundStyle(.secondary)
//                        Text("Sepete film eklenmemiş.")
//                            .foregroundStyle(.secondary)
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // CardScreen.swift  (List içindeki ForEach bloğunu güncelle)
                    List {
                        ForEach(vm.items) { item in
                            NavigationLink {
                                DetailScreen(movie: vm.asMovie(item))   // 👈 detaya git
                            } label: {
                                HStack(spacing: 12) {
                                    if let url = vm.imageURL(for: item) {
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .empty:
                                                ZStack { Rectangle().fill(Color.gray.opacity(0.15)); ProgressView() }
                                            case .success(let img):
                                                img.resizable().scaledToFill()
                                            case .failure:
                                                ZStack { Rectangle().fill(Color.gray.opacity(0.15)); Image(systemName: "photo") }
                                            @unknown default: Color.clear
                                            }
                                        }
                                        .frame(width: 60, height: 84)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.name ?? "—").font(.headline)
                                        Text("\(item.price ?? 0) ₺")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }

                                    Spacer()

                                    let qty = item.orderAmount ?? 1
                                    Stepper(value: Binding(
                                        get: { qty },
                                        set: { vm.setQuantity(for: item, to: max(1, $0)) }
                                    ), in: 1...99) {
                                        Text("x\(qty)").monospacedDigit()
                                    }
                                    .frame(width: 120)
                                }
                            }
                            .buttonStyle(.plain) // stepper tıklaması push’u tetiklemesin
                        }
                        .onDelete(perform: vm.delete)  // 👈 sağa kaydır sil
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .safeAreaInset(edge: .bottom) {
                // Toplam barı
                HStack {
                    Text("Toplam:")
                        .font(.headline)
                    Spacer()
                    Text("\(vm.totalPrice) ₺")
                        .font(.title3).bold()
                        .monospacedDigit()
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
            }
            .navigationTitle("Sepet")
            .task { vm.load() }
            .alert("Hata", isPresented: .constant(vm.errorMessage != nil)) {
                Button("Tamam") { vm.errorMessage = nil }
            } message: {
                Text(vm.errorMessage ?? "")
            }
        }
    }
}

#Preview {
    CardScreen()
}
