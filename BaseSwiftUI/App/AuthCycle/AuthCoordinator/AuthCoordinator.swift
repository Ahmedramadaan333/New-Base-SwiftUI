//
//  AppRoot.swift
//  CTF
//
//  Created by Ahmed Ramadan on 16/11/2025.
//

import Foundation


final class AuthCoordinator: BaseCoordinator<AuthRoute> {
    var onLoginSuccess: ((Bool) -> Void)?
    @Published var modalRoute: AuthModalRoute?
    var onFinishAuth: (() -> Void)?
    
    func loginSucceeded(isGuest: Bool = false) {
        print("🟢 AuthCoordinator.loginSucceeded(isGuest: \(isGuest)) fired")
        onLoginSuccess?(isGuest)
        reset()
        modalRoute = nil
    }
    func present(_ modal: AuthModalRoute) {
        modalRoute = modal
    }
    
    func dismissModal() {
        modalRoute = nil
    }
    
    func continueAsGuest() {
        UserDefaults.isLogin = false
        onFinishAuth?()
    }
}
