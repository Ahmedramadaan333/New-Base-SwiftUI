//
//  DeleteAccountUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class DeleteAccountUseCase {

    private let repository: MoreRepositoryProtocol

    init(repository: MoreRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> BaseResponse<String> {
        try await repository.deleteAccount()
    }
}
