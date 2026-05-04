//
//  PushNotificationType.swift
//  BaseSwiftUI
//

import Foundation

// TODO: Replace example cases with your app's actual notification types.
// Each rawValue must match the "type" field your backend sends in the push payload.
enum PushNotificationType: String {
    case adminMessage  = "admin_notification"
    case deleteAccount = "delete_account_notification"
    // Add more cases as needed...
}

struct PushPayload: Hashable {
    let type: PushNotificationType
    let title: String?
    let body: String?

    init?(userInfo: [AnyHashable: Any]) {
        guard let typeString = userInfo["type"] as? String,
              let type = PushNotificationType(rawValue: typeString)
        else { return nil }
        self.type  = type
        self.title = userInfo["title"] as? String
        self.body  = userInfo["body"]  as? String
    }
}

extension Notification.Name {
    static let pushDidReceiveForeground   = Notification.Name("app.push.didReceiveForeground")
    static let pushDidTap                 = Notification.Name("app.push.didTap")
    static let notificationsShouldRefresh = Notification.Name("app.notifications.shouldRefresh")
}
