//
//  OrderCycleRootView.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import SwiftUI

struct OrderCycleRootView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var orderCycleCoordinator: OrderCycleCoordinator

    var body: some View {
        NavigationStack(path: $orderCycleCoordinator.path) {
            OrderCycleView(viewModel: orderCycleCoordinator.container.makeOrderCycleViewModel())
                .navigationDestination(for: OrderCycleRoute.self) { route in
                    orderCycleCoordinator.destination(for: route)
                        .toolbar(.hidden, for: .tabBar)
                }
        }
        .environmentObject(appCoordinator)
        .environmentObject(orderCycleCoordinator)
    }
}
