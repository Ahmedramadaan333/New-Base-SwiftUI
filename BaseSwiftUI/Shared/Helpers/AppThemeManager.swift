//
//  AppThemeManager.swift
//  NewSwiftUIBase
//

import SwiftUI

final class AppThemeManager: ObservableObject {

    @AppStorage("isDarkMode") var isDarkMode: Bool = false {
        didSet { objectWillChange.send() }
    }

    var colorScheme: ColorScheme {
        isDarkMode ? .dark : .light
    }
}
