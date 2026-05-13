//
//  NotificationRepositoryProtocol.swift
//  BaseSwiftUI
//

import Foundation

protocol NotificationRepositoryProtocol {
    func getNotifications(page: Int) async throws -> NotificationsListData?
    func deleteNotification(id: String) async throws -> BaseResponse<String>
    func deleteAll() async throws -> BaseResponse<String>
}
