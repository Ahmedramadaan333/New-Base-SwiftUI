//
//  ExampleView.swift
//  BaseSwiftUI
//
//  Template: SwiftUI View for a feature screen.
//  Uses BaseScreen wrapper for consistent navigation bar and background.
//

import SwiftUI

struct ExampleView: View {

    @StateObject private var viewModel = ExampleViewModel()

    var body: some View {
        BaseScreen(title: "example_title".localized) {
            VStack(spacing: 16) {
                // TODO: Build your UI here using items from viewModel.
                Text("Example Feature")
                    .font(AppFont.semiBold(size: 18))
            }
            .padding()
        }
        .alert(for: viewModel)
        .loader(for: viewModel)
        .onAppear { viewModel.load() }
    }
}
