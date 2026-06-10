//
//  OrderData.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation

struct OrderData: Codable {
    var orders: [OrderModel]?
}

struct OrderModel: Identifiable, Codable, Hashable {
    var id: Int
    var status: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case status
        case createdAt = "created_at"
    }
}
