//
//  AppAlertStyle.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//


import SwiftUI

enum AppAlertStyle {
    case success
    case error
    case warning
    case info
}

struct AppAlert: Identifiable, Equatable {
    let id = UUID()
    let title: String? 
    let message: String?
    let style: AppAlertStyle
}

extension AppAlertStyle {
    var iconName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.octagon.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .info: return "info.circle.fill"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .success: return Color.green
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        }
    }
}
