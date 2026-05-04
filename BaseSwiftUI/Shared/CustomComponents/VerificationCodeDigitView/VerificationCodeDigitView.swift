//
//  VerificationCodeDigitView.swift
//  One Click
//
//  Created by Mohamed Elmemy on 17/11/2025.
//


import SwiftUI
import Combine

// MARK: - VerificationCodeDigitView
struct VerificationCodeDigitView: View {
    @Binding var text: String
    var isFocused: Bool

    private var borderColor: Color {
        if !text.isEmpty || isFocused {
            return Color.primaryMain
        } else {
            return Color.gray
        }
    }

    var body: some View {
        TextField("", text: $text)
            .font(.title)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .frame(width: 60, height: 60)

            .background(Color.white)
            .cornerRadius(12)

            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
            )
            .onReceive(Just(text)) { newValue in
                if newValue.count > 1 {
                    text = String(newValue.prefix(1))
                }
            }
    }
}
