//
//  Language.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import Foundation
import SwiftUI

class AppLanguageManager: ObservableObject {
    static let shared = AppLanguageManager()

    /// Drives the app-level loader while a language switch is being applied.
    /// Shown on the screen the language sheet was presented from (not the sheet).
    @Published var isApplyingLanguage: Bool = false

    // Persist the selected language and notify observers when it changes
    @AppStorage("selectedLanguage") var selectedLanguage: String = "en" {
        didSet {
            // Notify SwiftUI views bound to this object
            objectWillChange.send()
            // Keep AppleLanguages in sync for system-level RTL/layout behaviors if used elsewhere
            UserDefaults.standard.set([selectedLanguage], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            // Swap the localization bundle + UIKit direction live, no restart needed
            applyLanguageGlobals()
        }
    }


    init() {
        // Seed a default if not present
        if UserDefaults.standard.string(forKey: "selectedLanguage") == nil {
            let code = Locale.current.language.languageCode?.identifier ?? "en"
            UserDefaults.standard.set(code, forKey: "selectedLanguage")
            // Also set AppleLanguages to align with the initial selection
            UserDefaults.standard.set([code], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
        // Apply the persisted language at launch (bundle + layout direction)
        applyLanguageGlobals()
    }

    /// Swaps the runtime localization bundle and forces the matching UIKit
    /// semantic direction so `.localized` strings and UIKit-backed views update
    /// immediately when the language changes.
    private func applyLanguageGlobals() {
        Bundle.setLanguage(selectedLanguage)
        AppLanguageManager.handleViewDirection(isRTL: selectedLanguage == Languages.ar)
    }

    /// Forces UIKit appearance direction to match the selected language.
    /// SwiftUI views follow `\.layoutDirection`; this covers UIKit-backed views.
    static func handleViewDirection(isRTL: Bool) {
        let attribute: UISemanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = attribute
        UIStackView.appearance().semanticContentAttribute = attribute
        UICollectionView.appearance().semanticContentAttribute = attribute
        UINavigationBar.appearance().semanticContentAttribute = attribute
        UITabBar.appearance().semanticContentAttribute = attribute
        UISwitch.appearance().semanticContentAttribute = attribute
        UIButton.appearance().semanticContentAttribute = attribute
        UILabel.appearance().semanticContentAttribute = attribute
        UIImageView.appearance().semanticContentAttribute = attribute
    }
    
    enum Languages {
        static let en = "en"
        static let ar = "ar"
    }
    
    static func currentLanguage() -> String {
        let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
        let firstLanguage = languages.firstObject as! String
        return firstLanguage
    }
    static func setAppLanguage(lang: String) {
        guard !self.currentLanguage().lowercased().contains(lang.lowercased()) else {return}
        UserDefaults.standard.set([lang, currentLanguage()], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()

    }
    static func apiLanguage() -> String {
        return self.currentLanguage().contains(Languages.ar) ? Languages.ar : Languages.en
    }
    
    static func currentLang() -> appLanguage {
        return self.currentLanguage().contains(Languages.ar) ? .arabic : .english
    }
    
    static func isRTL() -> Bool {
        return self.currentLanguage().contains(Languages.ar) ? true : false
    }
    
    var apiLanguage: String {
        selectedLanguage.contains("ar") ? "ar" : "en"
    }
    var isRTL: Bool {
        selectedLanguage == "ar"
    }
    
    var layoutDirection: LayoutDirection {
        selectedLanguage == "ar" ? .rightToLeft : .leftToRight
    }

    func toggleLanguage() {
        selectedLanguage = selectedLanguage == "ar" ? "en" : "ar"
    }

    func setLanguage(_ lang: String) {
        selectedLanguage = lang
    }

    /// Switches the language with the app loader showing on the presenting screen.
    /// Call this right after dismissing the language sheet. The loader stays up
    /// while the localization bundle + layout direction swap and the UI rebuilds.
    func changeLanguage(to lang: String) {
        guard lang != selectedLanguage else { return }
        isApplyingLanguage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            guard let self else { return }
            self.setLanguage(lang)
            // Keep the loader up briefly so the rebuilt UI settles smoothly.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.isApplyingLanguage = false
            }
        }
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    var validationLocalized: String {
        return NSLocalizedString(self, tableName: "ValidationLocalized", bundle: Bundle.main, value: "", comment: "")
    }
    var helperLocalizable: String {
        return NSLocalizedString(self, tableName: "HelperLocalizable", bundle: Bundle.main, value: "", comment: "")
    }
    
}
enum appLanguage: String {
    case english = "en"
    case arabic = "ar"
}

