//
//  AuthVerificationCodeViewModel.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//

import SwiftUI

struct AppRootView: View {
    @StateObject private var appCoordinator = AppCoordinator()
    @StateObject private var alertCenter = AlertCenter.shared
    @StateObject private var themeManager = AppThemeManager()

    var body: some View {
        RootCoordinatorView()
            .environmentObject(appCoordinator)
            .environmentObject(alertCenter)
            .environmentObject(themeManager)
            .preferredColorScheme(themeManager.colorScheme)
            .safeAreaInset(edge: .top, spacing: 0) {
                if let alert = alertCenter.currentAlert {
                    AppAlertBanner(alert: alert) {
                        alertCenter.dismiss()
                    }
                    .transition(
                        .move(edge: .top)
                            .combined(with: .opacity)
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
            }
    }
}
