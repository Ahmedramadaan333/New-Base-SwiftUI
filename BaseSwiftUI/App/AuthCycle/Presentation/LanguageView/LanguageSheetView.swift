//
//  LanguageSheetView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 18/11/2025.
//


import SwiftUI

struct LanguageSheetView: View {

    let onClose: () -> Void

    @ObservedObject private var languageManager = AppLanguageManager.shared
    @State private var pendingLanguage: appLanguage

    init(onClose: @escaping () -> Void) {
        self.onClose = onClose
        let current = appLanguage(rawValue: AppLanguageManager.shared.selectedLanguage) ?? .arabic
        _pendingLanguage = State(initialValue: current)
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("change_language_title".localized)
                .font(AppFont.bold(size: 16))
                .padding(.top, 24)

            VStack(spacing: 0) {
                languageRow(title: "العربية", language: .arabic)
                Divider()
                languageRow(title: "English", language: .english)
            }
            .background(Color.clear)
            .cornerRadius(12)
            .padding(.horizontal)

            MainAppButton(title: "change_title".localized) {
                applyChangeIfNeeded()
            }
            .padding(.horizontal)

            Spacer(minLength: 8)
        }
        .padding(.bottom)
        .background(Color.clear.ignoresSafeArea())
    }

    private func languageRow(title: String, language: appLanguage) -> some View {
        Button {
            pendingLanguage = language
        } label: {
            HStack {
                Image(systemName: pendingLanguage == language ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(pendingLanguage == language ? .primaryMain : .gray.opacity(0.4))
                Text(title)
                    .font(AppFont.regular(size: 14))
                    .foregroundColor(.primary)

                Spacer()

            }
            .padding()
            .background(Color.clear.ignoresSafeArea())

        }
    }

    private func applyChangeIfNeeded() {
        let current = appLanguage(rawValue: languageManager.selectedLanguage) ?? .arabic
        guard current != pendingLanguage else {
            onClose()
            return
        }

        // Dismiss the sheet first, then apply the change. The app loader is shown
        // on the presenting screen (driven by AppLanguageManager.isApplyingLanguage)
        // while the localization bundle + layout direction swap — no Settings, no restart.
        onClose()
        languageManager.changeLanguage(to: pendingLanguage.rawValue)
    }
}
