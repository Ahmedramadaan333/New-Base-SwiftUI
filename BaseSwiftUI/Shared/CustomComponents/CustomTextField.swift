//
//  CustomTextField.swift
//  CTF
//
//  Created by Ahmed Ramadan on 08/12/2025.
//


import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    var submitLabel: SubmitLabel = .done
    var isSecure: Bool = false
    var onCommit: () -> Void = {}

    private var isRTL: Bool { AppLanguageManager.shared.isRTL }

    private var appFont: UIFont {
        UIFont(name: "SomarRounded-Regular", size: 14) ??
        UIFont.systemFont(ofSize: 14)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = keyboardType
        textField.returnKeyType = .done
        textField.isSecureTextEntry = isSecure
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.setContentHuggingPriority(.required, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.font = appFont
        textField.textColor = .black
        textField.textAlignment = isRTL ? .right : .left
        textField.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight

        updatePlaceholder(for: textField)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.font = appFont
        uiView.textAlignment = isRTL ? .right : .left
        uiView.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        uiView.returnKeyType = .done
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
            uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        updatePlaceholder(for: uiView)
    }

    private func updatePlaceholder(for textField: UITextField) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = isRTL ? .right : .left
        paragraphStyle.baseWritingDirection = isRTL ? .rightToLeft : .leftToRight

        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font: appFont,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField
        init(_ parent: CustomTextField) { self.parent = parent }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.onCommit()
            textField.resignFirstResponder()
            return true
        }
    }
}

