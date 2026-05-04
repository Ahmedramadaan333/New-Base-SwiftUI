//
//  AppLang.swift
//  CTF
//
//  Created by Ahmed Ramadan on 07/12/2025.
//


import SwiftUI

enum AppLang {
    static var isRTL: Bool {
        AppLanguageManager.shared.isRTL
    }
    
    static var layoutDirection: LayoutDirection {
        AppLanguageManager.shared.layoutDirection
    }
}
