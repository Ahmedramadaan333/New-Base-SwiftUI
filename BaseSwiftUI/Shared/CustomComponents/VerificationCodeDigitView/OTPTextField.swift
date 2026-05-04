//
//  OTPTextField.swift
//  CTF
//
//  Created by Ahmed Ramadan on 24/11/2025.
//


import SwiftUI

final class OTPTextField: UITextField {
    var onDeleteBackward: (() -> Void)?

    override func deleteBackward() {
        if (text ?? "").isEmpty {
            onDeleteBackward?()
        }
        super.deleteBackward()
    }
}

struct OTPTextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    var isFirstResponder: Bool
    var onDeleteBackward: () -> Void

    func makeUIView(context: Context) -> OTPTextField {
        let textField = OTPTextField()
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.delegate = context.coordinator
        textField.onDeleteBackward = onDeleteBackward
        return textField
    }

    func updateUIView(_ uiView: OTPTextField, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }

        uiView.onDeleteBackward = onDeleteBackward

        if isFirstResponder && !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        } else if !isFirstResponder && uiView.isFirstResponder {
            uiView.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {

            if string.isEmpty {
                text = ""
                return true
            }

            guard string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil else {
                return false
            }

            text = String(string.prefix(1))
            textField.text = text
            return false
        }
    }
}
