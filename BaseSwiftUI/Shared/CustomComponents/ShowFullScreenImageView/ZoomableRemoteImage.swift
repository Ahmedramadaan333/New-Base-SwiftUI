//
//  ZoomableRemoteImage.swift
//  CTF
//
//  Created by Ahmed Ramadan on 22/12/2025.
//


import SwiftUI

struct ZoomableRemoteImage: View {
    let url: String

    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 1

    var body: some View {
        RemoteImageView(url: url)
            .scaledToFit()
            .scaleEffect(scale)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        let delta = value / lastScale
                        lastScale = value
                        scale = min(max(scale * delta, 1), 4)
                    }
                    .onEnded { _ in
                        lastScale = 1
                        if scale < 1 { scale = 1 }
                    }
            )
            .onTapGesture(count: 2) {
                withAnimation(.easeOut(duration: 0.2)) {
                    scale = (scale > 1) ? 1 : 2
                }
            }
    }
}

extension View {
    func imageViewer(
        isPresented: Binding<Bool>,
        urls: [String],
        startIndex: Int
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            FullScreenImageViewer(urls: urls, startIndex: startIndex)
        }
    }
}
