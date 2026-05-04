//
//  SecondRedButton.swift
//  CTF
//
//  Created by Ahmed Ramadan on 22/12/2025.
//


import SwiftUI

struct SecondRedButton: View {
    let title: String
    let action: VoidCompletion

    var height: CGFloat = 50
    var cornerRadius: CGFloat = 14
    var horizontalPadding: CGFloat = 0
    var font: Font = AppFont.bold(size: 16)

    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(
            SecondRedButtonStyle(
                height: height,
                cornerRadius: cornerRadius,
                horizontalPadding: horizontalPadding,
                font: font
            )
        )
    }
}

struct SecondRedButtonStyle: ButtonStyle {
    var foregroundColor: Color = .red
    var backgroundColor: Color = Color.red.opacity(0.12)
    var height: CGFloat = 50
    var cornerRadius: CGFloat = 14
    var horizontalPadding: CGFloat = 0
    var font: Font = AppFont.bold(size: 16)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(font)
            .frame(maxWidth: .infinity, minHeight: height)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor.opacity(configuration.isPressed ? 0.85 : 1))
            )
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, horizontalPadding)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
