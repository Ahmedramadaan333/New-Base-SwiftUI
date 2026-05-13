//
//  ExampleViewModel.swift
//  BaseSwiftUI
//
//  Template: ViewModel for a feature screen.
//  Inherits BaseViewModel which provides:
//    - isLoadingSubject  (show/hide loader)
//    - errorSubject      (show error alert)
//    - successSubject    (show success alert)
//

import Foundation

@MainActor
final class ExampleViewModel: BaseViewModel {

    @Published private(set) var items: [ExampleModel] = []

    // MARK: - Dependencies

    private let getExampleUseCase: GetExampleUseCase

    // MARK: - Init

    init(getExampleUseCase: GetExampleUseCase) {
        self.getExampleUseCase = getExampleUseCase
        super.init()
    }

    func load() {
        Task { await fetch() }
    }

    private func fetch() async {
        startLoading()
        defer { stopLoading() }

        do {
            let result = try await getExampleUseCase.execute()
            items = result ?? []
        } catch {
            emitError(error)
        }
    }
}
