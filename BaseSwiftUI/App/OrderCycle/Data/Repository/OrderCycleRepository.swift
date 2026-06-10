//
//  OrderCycleRepository.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation

final class OrderCycleRepository: BaseRepository, OrderCycleRepositoryProtocol {

    func getOrders() async throws -> OrderData? {
        try await request(OrderCycleEndPoints.getOrders())
    }
}
