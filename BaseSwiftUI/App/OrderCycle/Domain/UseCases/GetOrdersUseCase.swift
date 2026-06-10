//
//  GetOrdersUseCase.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation

final class GetOrdersUseCase {

    private let repository: OrderCycleRepositoryProtocol

    init(repository: OrderCycleRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> OrderData? {
        try await repository.getOrders()
    }
}
