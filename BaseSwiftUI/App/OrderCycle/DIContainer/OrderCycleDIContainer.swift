//
//  OrderCycleDIContainer.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation

final class OrderCycleDIContainer {
    
    // MARK: - Repository
    
    func makeOrderCycleRepository() -> OrderCycleRepositoryProtocol {
        OrderCycleRepository()
    }
    
    func makeOrderDetailsRepository() -> OrderDetailsRepositoryProtocol {
        OrderDetailsRepository()
    }
    
    // MARK: - Use Cases
    
    func makeGetOrdersUseCase() -> GetOrdersUseCase {
        GetOrdersUseCase(repository: makeOrderCycleRepository())
    }
    
    func makeGetOrderDetailsUseCase() -> GetOrderDetailsUseCase {
        GetOrderDetailsUseCase(repository: makeOrderDetailsRepository())
    }
    
    // MARK: - ViewModels
    
    func makeOrderCycleViewModel() -> OrderCycleViewModel {
        OrderCycleViewModel(getOrdersUseCase: makeGetOrdersUseCase())
    }
    

    func makeOrderDetailsViewModel(orderId: Int) -> OrderDetailsViewModel {
        OrderDetailsViewModel(orderId: orderId, getOrderDetailsUseCase: makeGetOrderDetailsUseCase())
    }
}
