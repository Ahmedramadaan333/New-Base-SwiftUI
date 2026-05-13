//
//  AppTextAreaView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 27/11/2025.
//


import SwiftUI

struct AppTextAreaView: View {
    @Binding var text: String

    let title: String
    let placeholder: String
    var minHeight: CGFloat = 120
    var hasError: Bool = false
    var errorMessage: String = ""

    @FocusState private var isFocused: Bool

    private var borderColor: Color {
        if hasError { return .red }
        if isFocused || !text.trimWhiteSpace().isEmpty {
            return Color(.primaryMain)
        } else {
            return Color(.systemGray4)
        }
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Text(title)
                .font(AppFont.medium(size: 14))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(borderColor, lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.cardBackground)
                    )

                TextEditor(text: $text)
                    .focused($isFocused)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .frame(minHeight: minHeight, alignment: .topLeading)
                    .background(Color.clear)
                    .onAppear {
                        UITextView.appearance().backgroundColor = .clear
                    }

                if text.trimWhiteSpace().isEmpty {
                    Text(placeholder)
                        .font(AppFont.regular(size: 14))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                }
            }

            if hasError && !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(AppFont.regular(size: 12))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

