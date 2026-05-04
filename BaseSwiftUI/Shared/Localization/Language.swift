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
    
    // Persist the selected language and notify observers when it changes
    @AppStorage("selectedLanguage") var selectedLanguage: String = "en" {
        didSet {
            // Notify SwiftUI views bound to this object
            objectWillChange.send()
            // Keep AppleLanguages in sync for system-level RTL/layout behaviors if used elsewhere
            UserDefaults.standard.set([selectedLanguage], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
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

