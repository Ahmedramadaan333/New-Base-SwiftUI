//
//  HomeCoordinator.swift
//  CTF
//
//  Created by Ahmed Ramadan on 17/11/2025.
//


import SwiftUI

@MainActor
final class HomeCoordinator: BaseCoordinator<HomeRoute> {

    @ViewBuilder
    func destination(for route: HomeRoute) -> some View {
        switch route {
        case .createOrder:
            CreateOrderView()
        }
    }

    func show(_ route: HomeRoute) {
        path.append(route)
    }
    func replaceTop(with route: HomeRoute) {
        if !path.isEmpty { path.removeLast() }
        path.append(route)
    }
}

