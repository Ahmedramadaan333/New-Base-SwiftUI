//
//  OrderDetailsView.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import SwiftUI

struct OrderDetailsView: View {

    @StateObject var viewModel: OrderDetailsViewModel
    @EnvironmentObject private var orderCycleCoordinator: OrderCycleCoordinator

    init(viewModel: OrderDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        BaseView(title: "order_details_title".localized) {
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        
                        Text("\(viewModel.orderDetails?.id ?? 0) order number")
                            .font(.title)
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .alert(for: viewModel)
        .loader(for: viewModel)
    }
}
