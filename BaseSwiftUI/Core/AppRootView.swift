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
    @ObservedObject private var languageManager = AppLanguageManager.shared

    var body: some View {
        RootCoordinatorView()
            // Rebuild the whole tree when the language changes so `.localized`
            // strings and layout direction refresh live (no restart / Settings).
            .id(languageManager.selectedLanguage)
            .environment(\.locale, Locale(identifier: languageManager.selectedLanguage))
            .environment(\.layoutDirection, languageManager.layoutDirection)
            .environmentObject(appCoordinator)
            .environmentObject(alertCenter)
            .environmentObject(themeManager)
            .preferredColorScheme(themeManager.colorScheme)
            // App-level language-change loader: shown on the screen the language
            // sheet was presented from, kept outside `.id` so it survives the rebuild.
            .overlay {
                if languageManager.isApplyingLanguage {
                    AppLoaderView(asset: .defaultLottie)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: languageManager.isApplyingLanguage)
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
