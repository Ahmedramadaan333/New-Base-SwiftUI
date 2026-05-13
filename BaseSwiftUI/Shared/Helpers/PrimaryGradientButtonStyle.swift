//
//  PrimaryGradientButtonStyle.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//

import SwiftUI

// MARK: - Styles & helpers

private struct PrimaryGradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(
                LinearGradient(
                    colors: [Color(hex: 0x1FAE5B), Color(hex: 0x0F8C46)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
    
    /// Adaptive text color — black in light mode, white in dark mode.
    static let primaryText = Color.primary
    /// Adaptive secondary text color — follows system secondary label color.
    static let secondaryText = Color.secondary
}


 struct HeaderBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.primaryMain, Color.secondaryMain],
                startPoint: .top,
                endPoint: .bottom
            )

            // Pattern overlay
            Image(.back)
                .resizable()
                .scaledToFill()
                .opacity(0.25)
        }
        .clipShape(RoundedCorner(radius: 24, corners: [.bottomLeft, .bottomRight]))
    }
}

