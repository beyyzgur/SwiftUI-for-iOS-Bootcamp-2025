//
//  BannerCarousel.swift
//  TrendyolUI
//
//  Created by beyyzgur on 16.09.2025.
//

import SwiftUI


struct BannerCarousel: View {
    let items: [PromoBanner]
    @State private var index = 0
    
    var body: some View {
        TabView(selection: $index) {
            ForEach(items.indices, id: \.self) { i in
                ZStack(alignment: .bottomLeading) {
                    if let imgName = items[i].imageName,
                       let uiImg = UIImage(named: imgName) {
                        Image(uiImage: uiImg)
                            .resizable()
                            .frame(height: 140)
                            .clipped()
                            .cornerRadius(12)
                    } else {
                        RoundedRectangle(cornerRadius: UIConst.corner)
                            .fill(AppColor.trendyolTuruncusu.opacity(0.85))
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(items[i].title).font(.headline).bold()
                        Text(items[i].subtitle).font(.subheadline)
                    }
                    .foregroundStyle(AppColor.white)
                    .padding(5)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                }
                .frame(height: 140)
                .padding(.horizontal, 16) // ikincisini 16 yap bi
                .tag(i)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .frame(height: 160)
    }
}
