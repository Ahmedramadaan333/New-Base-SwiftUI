//
//  ToggleNotificationsUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class ToggleNotificationsUseCase {

    private let repository: MoreRepositoryProtocol

    init(repository: MoreRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> BaseResponse<User> {
        try await repository.changeNotificationsStatus()
    }
}
