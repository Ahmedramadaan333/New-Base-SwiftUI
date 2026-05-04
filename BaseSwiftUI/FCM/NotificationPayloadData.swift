//
//  NotificationPayloadData.swift
//  BaseSwiftUI
//
//  Extend this struct to match extra fields your backend puts in the
//  push notification "data" object.
//

import Foundation

struct NotificationPayloadData: Codable, Hashable {
    // TODO: Add app-specific payload fields here, then add a CodingKeys enum.
    // Example:
    // var someId: Int?
    // enum CodingKeys: String, CodingKey {
    //     case someId = "some_id"
    // }

    func toPushPayload(typeString: String?, title: String?, body: String?) -> PushPayload? {
        var info: [AnyHashable: Any] = [:]
        if let t = typeString { info["type"] = t }
        if let t = title { info["title"] = t }
        if let b = body { info["body"] = b }
        return PushPayload(userInfo: info)
    }
}
