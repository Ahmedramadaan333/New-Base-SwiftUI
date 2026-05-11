//
//  NotificationsRoute.swift
//  CTF
//
//  Created by Ahmed Ramadan on 29/12/2025.
//


import SwiftUI

enum NotificationsRoute: Hashable {
    case notifications
}

final class NotificationsCoordinator: BaseCoordinator<NotificationsRoute> { }

extension NotificationsCoordinator {
    @ViewBuilder
    func destination(for route: NotificationsRoute) -> some View {
        switch route {
        case .notifications:
            NotificationsView()
        }
    }
}
