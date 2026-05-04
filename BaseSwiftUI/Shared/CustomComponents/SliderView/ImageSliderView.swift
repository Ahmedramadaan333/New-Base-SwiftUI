//
//  RemoteImageView.swift
//  CTF
//
//  Created by Mohamed on 08/12/2025.
//


import SwiftUI

struct ImageSliderView: View {

    // MARK: - Properties

    let images: [ImageModel]

    // MARK: - State

    @State private var currentIndex: Int = 0
    @State private var tabViewID = UUID()
    @State private var lastInteractionTime = Date()

    // MARK: - Configuration

    private enum Config {
        static let sliderHeight: CGFloat = 180
        static let cornerRadius: CGFloat = 16
        static let horizontalPadding: CGFloat = 16
        static let indicatorSpacing: CGFloat = 8
        static let autoScrollInterval: TimeInterval = 2
        static let animationDuration: Double = 0.45
    }

    // MARK: - Computed Properties

    private var isRTL: Bool {
        AppLanguageManager.isRTL()
    }

    private var displayImages: [ImageModel] {
        isRTL ? images.reversed() : images
    }

    private var hasMultipleImages: Bool {
        images.count > 1
    }

    // MARK: - Timer

    private let timer = Timer.publish(
        every: Config.autoScrollInterval,
        on: .main,
        in: .common
    ).autoconnect()

    // MARK: - Body

    var body: some View {
        VStack(spacing: 12) {
            imageSlider
            if hasMultipleImages {
                pageIndicator
            }
        }
    }

    // MARK: - View Components

    private var imageSlider: some View {
        TabView(selection: $currentIndex) {
            ForEach(displayImages.indices, id: \.self) { index in
                imageCard(for: index)
            }
        }
        .id(tabViewID)
        .frame(height: Config.sliderHeight)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .environment(\.layoutDirection, .leftToRight)
        .onReceive(timer, perform: handleTimerTick)
        .onAppear(perform: handleAppear)
        .onChange(of: currentIndex) { _ in handleIndexChange() }
    }

    private func imageCard(for index: Int) -> some View {
        RemoteImageView(url: displayImages[index].image)
            .scaledToFill()
            .frame(height: Config.sliderHeight)
            .cornerRadius(Config.cornerRadius)
            .padding(.horizontal, Config.horizontalPadding)
            .tag(index)
    }

    private var pageIndicator: some View {
        HStack(spacing: Config.indicatorSpacing) {
            ForEach(images.indices, id: \.self) { index in
                indicatorDot(for: index)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentIndex)
        .padding(.top, 8)
    }

    private func indicatorDot(for index: Int) -> some View {
        let displayIdx = displayIndex(from: index)
        let isSelected = currentIndex == displayIdx

        return Group {

            if isSelected {

                Capsule().frame(width: 20, height: 8)

            } else {

                Circle().frame(width: 8, height: 8)
            }
        }
        .foregroundColor(isSelected ? .primaryMain : .gray)
    }

    // MARK: - Index Conversion

    private func actualIndex(from displayIndex: Int) -> Int {
        isRTL ? (images.count - 1 - displayIndex) : displayIndex
    }

    private func displayIndex(from actualIndex: Int) -> Int {
        isRTL ? (images.count - 1 - actualIndex) : actualIndex
    }

    // MARK: - Actions

    private func handleAppear() {
        if isRTL {
            currentIndex = images.count - 1
        }

        // Force TabView rebuild for proper initialization
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            tabViewID = UUID()
        }
    }

    private func handleTimerTick(_ time: Date) {
        guard hasMultipleImages else { return }

        let timeSinceInteraction = Date().timeIntervalSince(lastInteractionTime)
        guard timeSinceInteraction >= Config.autoScrollInterval else { return }

        withAnimation(.easeInOut(duration: Config.animationDuration)) {
            advanceToNextImage()
        }
    }

    private func handleIndexChange() {
        lastInteractionTime = Date()
    }

    private func advanceToNextImage() {
        if isRTL {
            currentIndex =
                currentIndex > 0 ? currentIndex - 1 : images.count - 1
        } else {
            currentIndex = (currentIndex + 1) % images.count
        }
    }
}
