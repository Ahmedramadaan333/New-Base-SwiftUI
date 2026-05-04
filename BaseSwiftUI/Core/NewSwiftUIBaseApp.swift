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
                .preferredColorScheme(.light)
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
        
        appearance.configureWithOpaqueBackground()
        
//        if let bgImage = UIImage(named: "backgroundNavStack") {
//            appearance.backgroundImage = bgImage
//        } else {
//            
//        }
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        
        if let chevronImage = UIImage(systemName: "chevron.backward") {
            appearance.setBackIndicatorImage(chevronImage, transitionMaskImage: chevronImage)
        }
        
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes      = [.foregroundColor: UIColor.clear]
        backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance = backButtonAppearance
        
        if let customTitleFont = UIFont(name: "SomarRounded-SemiBold", size: 16) {
            appearance.titleTextAttributes = [
                .font: customTitleFont,
                .foregroundColor: UIColor.black
            ]
        } else {
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.black
            ]
        }
        
        UINavigationBar.appearance().standardAppearance   = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance    = appearance
        
        UINavigationBar.appearance().tintColor = .black
        UIBarButtonItem.appearance().tintColor = .black
        
        UINavigationBar.appearance().isTranslucent = false
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
