//
//  LoginRequiredPopup.swift
//  CTF
//
//  Created by Ahmed Ramadan on 01/01/2026.
//


import SwiftUI

struct LoginRequiredPopup: View {

    @Binding var isPresented: Bool

    let title: String
    let buttonTitle: String
    let onLogin: () -> Void

    @State private var animateIn = false
    @GestureState private var dragY: CGFloat = 0

    var body: some View {
        ZStack {
            backgroundLayer

            popupCard
                .offset(y: cardOffset)
                .scaleEffect(cardScale)
                .opacity(animateIn ? 1 : 0)
                .animation(.spring(response: 0.42, dampingFraction: 0.82), value: animateIn)
                .animation(.spring(response: 0.35, dampingFraction: 0.9), value: dragY)
                .gesture(dragGesture)
                .onTapGesture { } 
        }
        .onAppear { present() }
        .onChange(of: isPresented) { newValue in
            if newValue { present() }
        }
        .transition(.opacity)
    }

    private var backgroundLayer: some View {
        Color.black
            .opacity(animateIn ? 0.45 : 0)
            .ignoresSafeArea()
            .onTapGesture { dismiss() }
            .animation(.easeInOut(duration: 0.18), value: animateIn)
            .blur(radius: animateIn ? 0 : 6)
    }

    private var popupCard: some View {
        VStack(spacing: 12) {

            LottieView(fileName: "logout", loopMode: .loop)
                .frame(width: 180, height: 180)

            Text(title)
                .font(AppFont.semiBold(size: 18))
                .foregroundStyle(Color.black.opacity(0.85))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)

            MainAppButton(title: buttonTitle) {
                dismiss {
                    onLogin()
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 10)
        }
        .padding(.top, 16)
        .frame(maxWidth: 340)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.18), radius: 22, x: 0, y: 14)
        .padding(.horizontal, 24)
    }

    private var cardOffset: CGFloat {
        let base: CGFloat = animateIn ? 0 : 50
        return base + max(0, dragY)
    }

    private var cardScale: CGFloat {
        if animateIn == false { return 0.92 }
        let shrink = min(max(dragY / 900, 0), 0.05)
        return 1 - shrink
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 6, coordinateSpace: .global)
            .updating($dragY) { value, state, _ in
                state = value.translation.height
            }
            .onEnded { value in
                if value.translation.height > 120 {
                    dismiss()
                }
            }
    }

    private func present() {
        withAnimation(.spring(response: 0.42, dampingFraction: 0.82)) {
            animateIn = true
        }
    }

    private func dismiss(completion: (() -> Void)? = nil) {
        withAnimation(.easeInOut(duration: 0.18)) {
            animateIn = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            isPresented = false
            completion?()
        }
    }
}


