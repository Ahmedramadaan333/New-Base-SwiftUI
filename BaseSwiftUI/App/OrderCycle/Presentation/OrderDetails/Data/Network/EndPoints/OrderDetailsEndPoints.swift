//
//  OrderDetailsEndPoints.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//
//  TODO: Replace the stub path with your actual order details API route.
//

import Foundation

struct OrderDetailsEndPoints {
    private init() {}
}

extension OrderDetailsEndPoints {

    static func getOrderDetails(id: Int) -> Endpoint<BaseResponse<OrderDetailsData>> {
        .init(
            method: .get,
            path: "orders/\(id)",                 // TODO: update path
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }
}
