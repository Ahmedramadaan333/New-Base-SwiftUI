//
//  NewSwiftUIBaseApp.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import SwiftUI
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager
import IQKeyboardToolbar
import GoogleMaps

@main
struct NewSwiftUIBaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        setupKeyboardManager()
        setupNavigationBarAppearance()
        GMSServices.provideAPIKey(AppConfig.googleMapsKey)

    }
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environment(\.locale, Locale(identifier: AppLanguageManager.shared.selectedLanguage))
                .environment(\.layoutDirection, AppLanguageManager.shared.layoutDirection)
                .onAppear {
                    if let token = UserDefaults.pushNotificationToken {
                        print("✅ [App] Current saved FCM Token: \(token)")
                    } else {
                        print("⚠️ [App] No FCM token saved yet")
                    }
                }
        }
    }
    
    private func setupNavigationBarAppearance() {

        let appearance = UINavigationBarAppearance()

        // MARK: - Background (Clean & Stable)
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear

        // MARK: - Back Button (Chevron only, no text)
        if let chevronImage = UIImage(systemName: "chevron.backward") {
            appearance.setBackIndicatorImage(chevronImage, transitionMaskImage: chevronImage)
        }

        let backButtonAppearance = UIBarButtonItemAppearance()

        backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]

        backButtonAppearance.highlighted.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]

        appearance.backButtonAppearance = backButtonAppearance

        // MARK: - Title Styling
        let font = UIFont(name: "SomarRounded-SemiBold", size: 16)
            ?? UIFont.systemFont(ofSize: 16, weight: .semibold)

        appearance.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.label
        ]

        // MARK: - Apply Appearance (All states)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance

        // MARK: - Tint Colors
        UINavigationBar.appearance().tintColor = .label
        UIBarButtonItem.appearance().tintColor = .label

        // MARK: - iOS behavior
        UINavigationBar.appearance().isTranslucent = true
    }
    
    private func setupKeyboardManager() {
        let keyboardManager = IQKeyboardManager.shared
        keyboardManager.isEnabled = true
        keyboardManager.resignOnTouchOutside = true
        let toolbarManager = IQKeyboardToolbarManager.shared
        toolbarManager.isEnabled = true
        
        toolbarManager.toolbarConfiguration.manageBehavior = .byPosition
        
        let doneConfig = IQBarButtonItemConfiguration(title: "Done".localized)
        toolbarManager.toolbarConfiguration.doneBarButtonConfiguration = doneConfig
        
        toolbarManager.toolbarConfiguration.tintColor = .primaryMain
    }
}
