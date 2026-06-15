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
    @ObservedObject private var languageManager = AppLanguageManager.shared

    var body: some View {
        HStack(spacing: 0) {
            // Backed by UITextField so the placeholder/text alignment is set
            // explicitly per language. SwiftUI's TextField leaves the field at
            // `.natural` alignment, which follows the launch-cached UIKit direction
            // and so only corrects after a restart on a live language switch.
            DirectionalTextField(
                text: $bodyTextField,
                placeholder: fieldType.fixedPlaceholder?.inputLocalized ?? "",
                isSecure: fieldType.isSecureTextEntry && !isSecureVisible,
                keyboardType: fieldType.keyboardType,
                isEnabled: isEnable,
                isRTL: languageManager.isRTL
            )
            .frame(maxWidth: .infinity)

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
        // Keep the row (eye button side) consistent with the field direction.
        .environment(\.layoutDirection, languageManager.isRTL ? .rightToLeft : .leftToRight)
    }
}

// MARK: - UIKit-backed field

private struct DirectionalTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool
    var keyboardType: UIKeyboardType
    var isEnabled: Bool
    var isRTL: Bool

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.font = UIFont(name: "SomarRounded-Regular", size: 14) ?? .systemFont(ofSize: 14)
        textField.textColor = .label
        textField.tintColor = UIColor(Color.primaryMain)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .next
        textField.borderStyle = .none
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.editingChanged(_:)),
            for: .editingChanged
        )
        return textField
    }

    func updateUIView(_ textField: UITextField, context: Context) {
        context.coordinator.text = $text

        if textField.text != text {
            textField.text = text
        }

        textField.isSecureTextEntry = isSecure
        textField.keyboardType = keyboardType
        textField.isEnabled = isEnabled
        // Re-set the font each update: toggling secure entry resets it.
        textField.font = UIFont(name: "SomarRounded-Regular", size: 14) ?? .systemFont(ofSize: 14)

        // Force the field's own direction from the current language. Setting these
        // on the instance overrides the global appearance proxy and refreshes live.
        textField.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        textField.textAlignment = isRTL ? .right : .left
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.placeholderText,
                .font: textField.font ?? .systemFont(ofSize: 14)
            ]
        )
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>

        init(text: Binding<String>) {
            self.text = text
        }

        @objc func editingChanged(_ sender: UITextField) {
            text.wrappedValue = sender.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
}
