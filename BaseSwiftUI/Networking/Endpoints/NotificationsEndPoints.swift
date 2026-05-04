//
//  NotificationsEndPoints.swift
//  CTF
//
//  Created by Ahmed Ramadan on 29/12/2025.
//


import Foundation

struct NotificationsEndPoints {
    private init() {}
}

extension NotificationsEndPoints {

    static func getNotifications(page: Int) -> Endpoint<BaseResponse<NotificationsListData>> {
        .init(
            method: .get,
            path: "user/notifications",
            queries: ["page": page],
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }

    static func deleteNotification(id: String) -> Endpoint<BaseResponse<String>> {
        .init(
            method: .delete,
            path: "user/notifications/delete/\(id)",
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }

    static func deleteAll() -> Endpoint<BaseResponse<String>> {
        .init(
            method: .delete,
            path: "user/notifications/delete-all",
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }
}
