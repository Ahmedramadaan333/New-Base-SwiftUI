//
//  ExampleViewModel.swift
//  BaseSwiftUI
//
//  Template: ViewModel for a feature screen.
//  Inherits BaseViewModel which provides:
//    - isLoadingSubject  (show/hide loader)
//    - errorSubject      (show error alert)
//    - successSubject    (show success alert)
//    - request<T>()      (make API calls)
//

import Foundation

@MainActor
final class ExampleViewModel: BaseViewModel {

    @Published private(set) var items: [ExampleModel] = []

    func load() {
        Task { await fetch() }
    }

    private func fetch() async {
        startLoading()
        defer { stopLoading() }

        // TODO: Replace with your actual endpoint.
        // Example:
        // do {
        //     let endpoint = ExampleEndPoint.getList()
        //     let response = try await request(endpoint)
        //     items = response ?? []
        // } catch {
        //     emitError(error)
        // }
    }
}
