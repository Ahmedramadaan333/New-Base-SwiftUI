//
//  AppConfig.swift
//  BaseSwiftUI
//
//  Reads configuration values from Info.plist so that secrets are never
//  hardcoded in source. Set the keys below in your target's Info.plist,
//  or use an .xcconfig file per build configuration (Debug / Release).
//

import Foundation

struct AppConfig {
    private init() {}

    /// Set API_BASE_URL in Info.plist (include trailing slash, e.g. "https://api.example.com/api/")
    static var apiBaseURL: String {
        Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String ?? ""
    }

    /// Set API_KEY in Info.plist
    static var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }

    /// Set GOOGLE_MAPS_KEY in Info.plist — remove if not using Google Maps
    static var googleMapsKey: String {
        Bundle.main.object(forInfoDictionaryKey: "GOOGLE_MAPS_KEY") as? String ?? ""
    }
}
