//
//  LottieWrapper.swift
//  CineGoApp
//
//  Created by beyyzgur on 27.09.2025.
//

import SwiftUI
import Lottie

struct LottieWrapper: UIViewRepresentable {
    let name: String
    var loopMode: LottieLoopMode = .loop
    var speed: CGFloat = 1.0

    func makeUIView(context: Context) -> LottieAnimationView {
        // Lottie 4.x’te bu initializer mevcut
        let view = LottieAnimationView(name: name)
        view.contentMode = .scaleAspectFit
        view.loopMode = loopMode
        view.animationSpeed = speed
        view.play()
        return view
    }

    func updateUIView(_ uiView: LottieAnimationView, context: Context) { }
}
