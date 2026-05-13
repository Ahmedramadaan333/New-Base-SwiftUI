//
//  NotificationRepository.swift
//  BaseSwiftUI
//

import Foundation

final class NotificationRepository: BaseRepository, NotificationRepositoryProtocol {

    func getNotifications(page: Int) async throws -> NotificationsListData? {
        try await request(NotificationsEndPoints.getNotifications(page: page))
    }

    func deleteNotification(id: String) async throws -> BaseResponse<String> {
        try await getFullResponse(NotificationsEndPoints.deleteNotification(id: id))
    }

    func deleteAll() async throws -> BaseResponse<String> {
        try await getFullResponse(NotificationsEndPoints.deleteAll())
    }
}
