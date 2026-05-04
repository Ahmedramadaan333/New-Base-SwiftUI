//
//  NetworkConstants.swift
//  BaseSwiftUI
//
//  Configure API_BASE_URL in your target's Info.plist.
//  For DEBUG vs RELEASE, use build configurations in Xcode (.xcconfig files).
//

import Foundation

struct NetworkConstants {
    private init() {}

    static var server: String {
        AppConfig.apiBaseURL
    }

    // TODO: Set SOCKET_PORT in Info.plist if your app uses Socket.IO
    static var socket: String {
        AppConfig.apiBaseURL
    }
}
