//
//  LoadingModifier.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//


import SwiftUI
import Combine

struct LoadingModifier<VM: BaseViewModel>: ViewModifier {
    @ObservedObject var viewModel: VM
    let asset: LoaderAsset
    
    @State private var isLoading: Bool = false
    
    func body(content: Content) -> some View {
        content
            .disabled(isLoading)
            .overlay(
                Group {
                    if isLoading {
                        AppLoaderView(asset: asset)
                            .transition(.opacity)
                    }
                }
            )
            .onReceive(viewModel.isLoadingSubject) { value in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isLoading = value
                }
            }
    }
}

extension View {
    func loader<VM: BaseViewModel>(
        for viewModel: VM,
        asset: LoaderAsset = .defaultLottie
    ) -> some View {
        self.modifier(LoadingModifier(viewModel: viewModel, asset: asset))
    }
}
