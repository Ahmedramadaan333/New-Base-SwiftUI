//
//  NotificationsRoute.swift
//  BaseSwiftUI
//

import SwiftUI

enum NotificationsRoute: Hashable {
    case notifications
}

final class NotificationsCoordinator: BaseCoordinator<NotificationsRoute> {
    let container = NotificationDIContainer()
}

extension NotificationsCoordinator {
    @ViewBuilder
    func destination(for route: NotificationsRoute) -> some View {
        switch route {
        case .notifications:
            NotificationsView(viewModel: container.makeNotificationsViewModel())
        }
    }
}
