//
//  OrderCycleView.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import SwiftUI

struct OrderCycleView: View {

    @StateObject var viewModel: OrderCycleViewModel
    @EnvironmentObject private var orderCycleCoordinator: OrderCycleCoordinator
    @EnvironmentObject private var appCoordinator: AppCoordinator

    init(viewModel: OrderCycleViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        BaseView(title: "orders_title".localized) {
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        // TODO: Build your orders UI here

                        MainAppButton(title: "Go To Order details") {
                            orderCycleCoordinator.push(.orderDetails(id: viewModel.orderId ?? 0))
                        }
                        
                        VStack (spacing: 8) {
                            ForEach (0..<10) { _ in
                                Text("Order Item")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                }
                .refreshable { viewModel.fetchOrders() }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .alert(for: viewModel)
        .loader(for: viewModel)
    }
}
