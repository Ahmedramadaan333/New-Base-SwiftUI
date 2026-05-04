//
//  AppCoordinator.swift
//  CTF
//
//  Created by Ahmed Ramadan on 17/11/2025.
//


import SwiftUI
import Combine

@MainActor
final class AppCoordinator: ObservableObject {
    
    @Published var root: AppRoot = .splash
    private var cancellables = Set<AnyCancellable>()
    
    var isLoggedIn: Bool {
        get { UserDefaults.isLogin }
        set { UserDefaults.isLogin = newValue }
    }
    
    let authCoordinator = AuthCoordinator()
    let tabsCoordinator = TabsCoordinator()
    
    init() {
        bindChildCoordinators()
        observeUnauthorized()
    }
    
    private func bindChildCoordinators() {
        authCoordinator.onLoginSuccess = { [weak self] isGuest in
            guard let self else { return }
            
            if !isGuest {
                self.isLoggedIn = true
            }
            self.showMainTabs()
        }

        authCoordinator.onFinishAuth = { [weak self] in
            self?.showMainTabs()
        }
    }

    // MARK: - Root switches
    
    private func observeUnauthorized() {
        NotificationCenter.default.publisher(for: .userUnauthorized)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.showAuth()
            }
            .store(in: &cancellables)
    }
    func decideInitialRoot() {
        root = isLoggedIn ? .mainTabs : .auth
    }
    
    func showSplash() {
        root = .splash
    }
    
    func showAuth() {
        isLoggedIn = false
        root = .auth
    }
    
    func showMainTabs() {
        tabsCoordinator.resetAll()
        root = .mainTabs
        tabsCoordinator.selectedTab = .home
        
    }
    
    private func handleLoginSuccess() {
        isLoggedIn = true
        showMainTabs()
    }
}

