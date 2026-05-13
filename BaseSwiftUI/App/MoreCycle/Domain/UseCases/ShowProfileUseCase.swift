//
//  ShowProfileUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class ShowProfileUseCase {

    private let repository: MoreRepositoryProtocol

    init(repository: MoreRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> User? {
        try await repository.showProfile()
    }
}
