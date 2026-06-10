//
//  OrderDetailsData.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation

struct OrderDetailsData: Codable {
    var id: Int?
    var status: String?
    var createdAt: String?
    var items: [OrderItemModel]?

    enum CodingKeys: String, CodingKey {
        case id
        case status
        case createdAt = "created_at"
        case items
    }
}

struct OrderItemModel: Identifiable, Codable, Hashable {
    var id: Int
    var name: String?
    var quantity: Int?
    var price: Double?
}
