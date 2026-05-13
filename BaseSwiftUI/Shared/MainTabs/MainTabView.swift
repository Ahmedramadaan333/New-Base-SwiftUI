//
//  MainTab.swift
//  CTF
//
//  Created by Ahmed Ramadan on 16/11/2025.
//

import SwiftUI

struct MainTabsRootView: View {

    @EnvironmentObject var tabsCoordinator: TabsCoordinator

    var body: some View {
        TabView(selection: $tabsCoordinator.selectedTab) {

            // Home Tab
            NavigationStack(path: $tabsCoordinator.homeCoordinator.path) {
                HomeRootView()
            }
            .tabItem {
                VStack {
                    Image(tabsCoordinator.selectedTab == .home ? "homeActive" : "homeInactive")
                    Text("main_title".localized)
                        .font(AppFont.bold(size: 12))
                }
            }
            .tag(MainTab.home)

            NavigationStack(path: $tabsCoordinator.moreCoordinator.path) {
                MoreRootView()
            }
            .tabItem {
                VStack {
                    Image(tabsCoordinator.selectedTab == .more ? "activeMore" : "inActiveMore")
                    Text("more_title".localized)
                        .font(AppFont.bold(size: 12))

                }
            }
            .tag(MainTab.more)
        }
        .toolbar(.visible, for: .tabBar)
        .environmentObject(tabsCoordinator.homeCoordinator)
        .environmentObject(tabsCoordinator.moreCoordinator)
        .tint(.primaryMain)
    }
}
