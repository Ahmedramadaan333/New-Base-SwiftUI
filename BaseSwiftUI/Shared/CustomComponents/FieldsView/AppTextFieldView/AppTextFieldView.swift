//
//  AppTextFieldView.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 10/06/2026.
//

import SwiftUI

struct AppTextFieldView: View {
    let type: AppInputFieldProtocol
    @Binding var textValue: String

    @ObservedObject private var languageManager = AppLanguageManager.shared

    var body: some View {
        AppTextInputContent(
            text: $textValue,
            field: type
        )
        .padding(.horizontal, 16)
        .environment(\.layoutDirection, languageManager.isRTL ? .rightToLeft : .leftToRight)
    }
}

private struct AppTextInputContent: View {

    @Binding var text: String
    let field: AppInputFieldProtocol

    @State private var errorMessage: String?
    @State private var hasStartedEditing = false

    var body: some View {
        VStack(alignment: .leading, spacing: InputFieldConstants.fieldSapcing) {

            // Title
            if let titleText = field.fieldType.fixedTitle,
               !titleText.trimWhiteSpace().isEmpty {
                HStack(spacing: 3) {
                    Text(titleText.inputLocalized)
                        .foregroundStyle(Color(.secondaryLabel))
                        .font(AppFont.regular(size: 13))

                    if field.isMandatory {
                        Text("*")
                            .foregroundStyle(.red)
                            .font(AppFont.regular(size: 13))
                    }

                    if field.isOptional {
                        Text("(Optional)".localized)
                            .foregroundStyle(Color(.tertiaryLabel))
                            .font(AppFont.regular(size: 13))
                    }

                    Spacer()
                }
            }

            // Field container
            HStack(spacing: 10) {
                AppTextFieldIcon(iconField: field.fieldType.icon)

                AppTextField(
                    bodyTextField: $text,
                    fieldType: field.fieldType
                )
                .onChange(of: text) { newValue in
                    if newValue.trimWhiteSpace().isEmpty {
                        errorMessage = nil
                        hasStartedEditing = false
                        return
                    }
                    hasStartedEditing = true
                    errorMessage = field.validate(newValue)
                }
            }
            .frame(height: InputFieldConstants.fieldHeight)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: InputFieldConstants.fieldCornerRaduis, style: .continuous)
                    .fill(Color(InputFieldConstants.containerBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: InputFieldConstants.fieldCornerRaduis, style: .continuous)
                    .stroke(borderColor, lineWidth: hasStartedEditing && hasError ? 1 : 0)
            )

            // Error
            if hasStartedEditing,
               let errorMessage,
               !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(AppFont.regular(size: 12))
                    .foregroundStyle(.red)
                    .padding(.horizontal, 4)
            }
        }
    }
}

// MARK: - Helpers

private extension AppTextInputContent {

    var hasError: Bool {
        !(errorMessage?.isEmpty ?? true)
    }

    var borderColor: Color {
        hasStartedEditing && hasError ? .red : .clear
    }
}
