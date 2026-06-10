//
//  OrderCycleEndPoints.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//
//  TODO: Replace the stub path with your actual orders API route.
//

import Foundation

struct OrderCycleEndPoints {
    private init() {}
}

extension OrderCycleEndPoints {

    static func getOrders() -> Endpoint<BaseResponse<OrderData>> {
        .init(
            method: .get,
            path: "orders",                       // TODO: update path
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }
}
