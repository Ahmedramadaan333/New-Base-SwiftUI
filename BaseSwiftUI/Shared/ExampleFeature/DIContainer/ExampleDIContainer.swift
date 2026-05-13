//
//  ExampleDIContainer.swift
//  BaseSwiftUI
//
//  Template: Factory that wires together the feature's layers.
//  The coordinator holds an instance and uses it in destination(for:).
//

import Foundation

final class ExampleDIContainer {

    // MARK: - Repository

    func makeExampleRepository() -> ExampleRepositoryProtocol {
        ExampleRepository()
    }

    // MARK: - Use Cases

    func makeGetExampleUseCase() -> GetExampleUseCase {
        GetExampleUseCase(repository: makeExampleRepository())
    }

    // MARK: - ViewModels

    @MainActor func makeExampleViewModel() -> ExampleViewModel {
        ExampleViewModel(getExampleUseCase: makeGetExampleUseCase())
    }
}
