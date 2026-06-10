//
//  OrderCycleCoordinator.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import SwiftUI

@MainActor
final class OrderCycleCoordinator: BaseCoordinator<OrderCycleRoute> {

    let container = OrderCycleDIContainer()

    @ViewBuilder
    func destination(for route: OrderCycleRoute) -> some View {
        switch route {
        case .orderDetails(let id):
            OrderDetailsView(viewModel: container.makeOrderDetailsViewModel(orderId: id))
        }
    }
        

    func show(_ route: OrderCycleRoute) {
        path.append(route)
    }

    func replaceTop(with route: OrderCycleRoute) {
        if !path.isEmpty { path.removeLast() }
        path.append(route)
    }
}
