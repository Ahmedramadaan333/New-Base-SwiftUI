//
//  GetNotificationsUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class GetNotificationsUseCase {

    private let repository: NotificationRepositoryProtocol

    init(repository: NotificationRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> NotificationsListData? {
        try await repository.getNotifications(page: page)
    }
}
