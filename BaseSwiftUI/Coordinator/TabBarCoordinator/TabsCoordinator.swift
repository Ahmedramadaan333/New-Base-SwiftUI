//
//  TabsCoordinator.swift
//  CTF
//
//  Created by Ahmed Ramadan on 17/11/2025.
//


// TabsCoordinator.swift
import Foundation

@MainActor
final class TabsCoordinator: ObservableObject {

    @Published var selectedTab: MainTab = .home

    var homeCoordinator = HomeCoordinator()
    var moreCoordinator = MoreCoordinator()

    func select(_ tab: MainTab) {
        selectedTab = tab
    }

    func resetAll() {
        homeCoordinator.reset()
        moreCoordinator.reset()
    }
}
