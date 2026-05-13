//
//  DeleteNotificationUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class DeleteNotificationUseCase {

    private let repository: NotificationRepositoryProtocol

    init(repository: NotificationRepositoryProtocol) {
        self.repository = repository
    }

    func executeOne(id: String) async throws -> BaseResponse<String> {
        try await repository.deleteNotification(id: id)
    }

    func executeAll() async throws -> BaseResponse<String> {
        try await repository.deleteAll()
    }
}
