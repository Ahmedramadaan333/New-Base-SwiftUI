//
//  HomeCoordinator.swift
//  BaseSwiftUI
//

import SwiftUI

@MainActor
final class HomeCoordinator: BaseCoordinator<HomeRoute> {

    let container = HomeDIContainer()

    @ViewBuilder
    func destination(for route: HomeRoute) -> some View {
        switch route {
        case .createOrder:
             EmptyView()
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
