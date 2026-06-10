//
//  OrderDetailsRepository.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation

final class OrderDetailsRepository: BaseRepository, OrderDetailsRepositoryProtocol {

    func getOrderDetails(id: Int) async throws -> OrderDetailsData? {
        try await request(OrderDetailsEndPoints.getOrderDetails(id: id))
    }
}
