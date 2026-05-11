//
//  HomeRootView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 14/12/2025.
//


import SwiftUI

struct HomeRootView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var homeCoordinator: HomeCoordinator

    var body: some View {
        NavigationStack(path: $homeCoordinator.path) {
            HomeView()
        }
        .environmentObject(appCoordinator)
        .environmentObject(homeCoordinator)
//        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(for: HomeRoute.self) { route in
            homeCoordinator.destination(for: route)
        }
    }
}
