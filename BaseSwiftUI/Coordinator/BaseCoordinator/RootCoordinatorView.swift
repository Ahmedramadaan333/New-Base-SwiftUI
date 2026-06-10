//
//  RootCoordinatorView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 16/11/2025.
//

import SwiftUI

struct RootCoordinatorView: View {

    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var termsCoordinator = TermsCoordinator()
    @StateObject private var notificationsCoordinator = NotificationsCoordinator()

    var body: some View {
        ZStack {
            switch appCoordinator.root {
            case .splash:
                SplashView()
                    .environmentObject(appCoordinator)

            case .auth:
                AuthRootView()
                    .environmentObject(appCoordinator.authCoordinator)

            
            case .mainTabs:
                MainTabsRootView()
                    .environmentObject(appCoordinator.tabsCoordinator)
                    .environmentObject(notificationsCoordinator)
            }

            NavigationStack(path: $termsCoordinator.path) {
                Color.clear
                    .navigationDestination(for: TermsRoute.self) { route in
                        termsCoordinator.destination(for: route)
                    }
            }
            .opacity(termsCoordinator.path.isEmpty ? 0 : 1)

            NavigationStack(path: $notificationsCoordinator.path) {
                Color.clear
                    .navigationDestination(for: NotificationsRoute.self) { route in
                        notificationsCoordinator.destination(for: route)
                    }
            }
            .opacity(notificationsCoordinator.path.isEmpty ? 0 : 1)
        }
        .environmentObject(termsCoordinator)
        .environmentObject(notificationsCoordinator)
        .onReceive(NotificationCenter.default.publisher(for: .pushDidTap)) { note in
            guard let payload = note.object as? PushPayload else { return }
            handlePushTap(payload)
        }
    }

    private func handlePushTap(_ payload: PushPayload) {
        guard appCoordinator.isLoggedIn else { return }
        // TODO: Add app-specific push routing cases here.
        // Route to the notifications screen as a default fallback.
        openNotifications()
    }

    private func openNotifications() {
        appCoordinator.showMainTabs()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.notificationsCoordinator.reset()
            self.notificationsCoordinator.push(.notifications)
        }
    }
}
