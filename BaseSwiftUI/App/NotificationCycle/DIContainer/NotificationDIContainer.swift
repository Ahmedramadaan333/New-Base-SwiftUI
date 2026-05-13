//
//  NotificationDIContainer.swift
//  BaseSwiftUI
//

import Foundation

final class NotificationDIContainer {

    // MARK: - Repository

    func makeNotificationRepository() -> NotificationRepositoryProtocol {
        NotificationRepository()
    }

    // MARK: - Use Cases

    func makeGetNotificationsUseCase() -> GetNotificationsUseCase {
        GetNotificationsUseCase(repository: makeNotificationRepository())
    }

    func makeDeleteNotificationUseCase() -> DeleteNotificationUseCase {
        DeleteNotificationUseCase(repository: makeNotificationRepository())
    }

    // MARK: - ViewModels

    @MainActor func makeNotificationsViewModel() -> NotificationsViewModel {
        NotificationsViewModel(
            getNotificationsUseCase: makeGetNotificationsUseCase(),
            deleteNotificationUseCase: makeDeleteNotificationUseCase()
        )
    }
}
