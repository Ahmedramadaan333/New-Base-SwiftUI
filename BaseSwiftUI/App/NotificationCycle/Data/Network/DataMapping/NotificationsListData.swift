//
//  NotificationsListData.swift
//  BaseSwiftUI
//

import Foundation

struct NotificationsListData: Codable {
    var data: [NotificationModel]?
    var pagination: Pagination?
}

struct NotificationModel: Codable, Identifiable, Hashable {
    var id: String?
    var type: String?
    var title: String?
    var body: String?
    var createdAt: String?
    var read: Int?
    var data: NotificationPayloadData?

    enum CodingKeys: String, CodingKey {
        case id, type, title, body, data, read
        case createdAt = "created_at"
    }

    var payload: PushPayload? {
        data?.toPushPayload(typeString: type, title: title, body: body)
    }
}
