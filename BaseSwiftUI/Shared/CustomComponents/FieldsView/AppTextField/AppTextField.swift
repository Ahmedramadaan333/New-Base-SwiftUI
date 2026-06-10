//
//  AppTextField.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 10/06/2026.
//
import SwiftUI

struct AppTextField: View {
    @Binding var bodyTextField: String
    var fieldType: TextFieldType
    var isEnable: Bool = true

    @State private var isSecureVisible = false

    var body: some View {
        HStack(spacing: 0) {
            Group {
                if fieldType.isSecureTextEntry && !isSecureVisible {
                    SecureField(
                        fieldType.fixedPlaceholder?.inputLocalized ?? "",
                        text: $bodyTextField
                    )
                } else {
                    TextField(
                        fieldType.fixedPlaceholder?.inputLocalized ?? "",
                        text: $bodyTextField
                    )
                }
            }
            .font(AppFont.regular(size: 14))
            .submitLabel(.next)
            .keyboardType(fieldType.keyboardType)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .foregroundStyle(Color(.label))
            .disabled(!isEnable)
            .tint(Color.primaryMain)

            if fieldType.isSecureTextEntry {
                Button {
                    isSecureVisible.toggle()
                } label: {
                    Image(systemName: isSecureVisible ? "eye.slash" : "eye")
                        .foregroundStyle(Color(.secondaryLabel))
                        .font(.system(size: 16, weight: .regular))
                }
            }
        }
    }
}
