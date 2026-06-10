//
//  GetOrderDetailsUseCase.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation

final class GetOrderDetailsUseCase {

    private let repository: OrderDetailsRepositoryProtocol

    init(repository: OrderDetailsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int) async throws -> OrderDetailsData? {
        try await repository.getOrderDetails(id: id)
    }
}
