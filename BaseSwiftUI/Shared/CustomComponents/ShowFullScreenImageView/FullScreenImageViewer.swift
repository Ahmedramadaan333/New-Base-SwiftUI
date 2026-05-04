//
//  FullScreenImageViewer.swift
//  CTF
//
//  Created by Ahmed Ramadan on 22/12/2025.
//

import SwiftUI

struct FullScreenImageViewer: View {
    let urls: [String]
    let startIndex: Int

    @Environment(\.dismiss) private var dismissEnv // Use environment dismiss to close the view

    @State private var index: Int
    @State private var dragOffsetY: CGFloat = 0
    @State private var appeared = false

    init(urls: [String], startIndex: Int) {
        self.urls = urls
        self.startIndex = startIndex
        _index = State(initialValue: max(0, min(startIndex, urls.count - 1)))
    }

    private var backgroundAlpha: CGFloat {
        let t = min(1, abs(dragOffsetY) / 400)
        return max(0.0, 1.0 - t * 0.8)
    }

    var body: some View {
        ZStack {
            Color.black
                .opacity(appeared ? backgroundAlpha : 0)
                .ignoresSafeArea()

            TabView(selection: $index) {
                ForEach(Array(urls.enumerated()), id: \.offset) { i, url in
                    ZoomableRemoteImage(url: url)
                        .tag(i)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .offset(y: dragOffsetY)
            .opacity(appeared ? 1 : 0)
        }
        .simultaneousGesture(dismissDragGesture) // important: allows both gestures
        .overlay(alignment: .topTrailing) {
            Button {
                dismissEnv() // Close the view using environment dismiss
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.white.opacity(0.12))
                    .clipShape(Circle())
                    .contentShape(Circle())
            }
            .buttonStyle(.plain)
            .padding(.top, 12)
            .padding(.trailing, 16)
            .zIndex(10) // important to overlay on top
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.2)) {
                appeared = true
            }
        }
    }

    private var dismissDragGesture: some Gesture {
        DragGesture(minimumDistance: 10, coordinateSpace: .local)
            .onChanged { value in
                dragOffsetY = value.translation.height
            }
            .onEnded { _ in
                let threshold: CGFloat = 200
                if abs(dragOffsetY) > threshold {
                    dismissEnv() // close view when dragging down enough
                } else {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                        dragOffsetY = 0
                    }
                }
            }
    }
}


