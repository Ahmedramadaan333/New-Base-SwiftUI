//
//  HomeRootView.swift
//  BaseSwiftUI
//

import SwiftUI

struct HomeRootView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var homeCoordinator: HomeCoordinator

    var body: some View {
        NavigationStack(path: $homeCoordinator.path) {
            HomeView(viewModel: homeCoordinator.container.makeHomeViewModel())
        }
        .environmentObject(appCoordinator)
        .environmentObject(homeCoordinator)
        .navigationDestination(for: HomeRoute.self) { route in
            homeCoordinator.destination(for: route)
                .toolbar(.hidden, for: .tabBar)
        }
    }
}
