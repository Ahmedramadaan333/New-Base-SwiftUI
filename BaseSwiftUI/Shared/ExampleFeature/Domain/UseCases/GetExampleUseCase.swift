//
//  GetExampleUseCase.swift
//  BaseSwiftUI
//
//  Template: Use case that fetches a list of ExampleModel items.
//  Replace "Example" with your feature name throughout.
//

import Foundation

final class GetExampleUseCase {

    private let repository: ExampleRepositoryProtocol

    init(repository: ExampleRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [ExampleModel]? {
        try await repository.getList()
    }
}
