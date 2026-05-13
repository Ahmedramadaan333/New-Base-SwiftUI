//
//  ExampleView.swift
//  BaseSwiftUI
//
//  Template: SwiftUI View for a feature screen.
//  ViewModel is injected via init — built by ExampleDIContainer.
//

import SwiftUI

struct ExampleView: View {

    @StateObject var viewModel: ExampleViewModel

    init(viewModel: ExampleViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

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
