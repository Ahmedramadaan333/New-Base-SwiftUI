//
//  AppLoaderView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//


import SwiftUI

struct AppLoaderView: View {
    let asset: LoaderAsset
    
    var body: some View {
        ZStack {
            
            Color.clear
                .background(.ultraThinMaterial)
                .ignoresSafeArea()

            Group {
                switch asset {
                case .gif(let name):
                    GIFView(name: name)

                case .lottie(let name):
                    LottieView(fileName: name)
                }
            }
            .frame(width: 200, height: 200)
            .background(.ultraThinMaterial) // optional glass behind loader
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: 8)
        }
    }
}
