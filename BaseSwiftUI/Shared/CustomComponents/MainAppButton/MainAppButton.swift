//
//  MainAppButton.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 30/07/2025.
//
import SwiftUI

typealias VoidCompletion = () -> Void
extension LinearGradient {
    static var mainVertical: LinearGradient {
        LinearGradient(
            colors: [
                Color("PrimaryMain"),
//                Color("SecondaryMain")
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}


struct MainAppButton: View {
    let title: String
    let action: VoidCompletion
    
    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(MainButtonStyle())
    }
}

struct MainButtonStyle: ButtonStyle {
    var background: LinearGradient = .mainVertical
    var foregroundColor: Color = .white
    var height: CGFloat = 48
    var cornerRadius: CGFloat = 16
    var horizontalPadding: CGFloat = 8
    var font: Font = AppFont.semiBold(size: 16)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(font)
            .frame(maxWidth: .infinity, minHeight: height)
            .background(
                background
                    .opacity(configuration.isPressed ? 0.8 : 1)
            )
            .foregroundStyle(foregroundColor)
            .cornerRadius(cornerRadius)
            .padding(.horizontal, horizontalPadding)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
