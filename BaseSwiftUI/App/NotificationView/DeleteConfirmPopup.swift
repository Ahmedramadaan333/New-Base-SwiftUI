//
//  DeleteConfirmPopup.swift
//  CTF
//
//  Created by Ahmed Ramadan on 30/12/2025.
//


import SwiftUI

struct DeleteConfirmPopup: View {

    let title: String
    let confirmTitle: String
    let cancelTitle: String
    let onConfirm: VoidCompletion
    let onCancel: VoidCompletion

    var body: some View {
        ZStack {
            Color.black.opacity(0.35)
                .ignoresSafeArea()
                .onTapGesture { onCancel() }

            VStack(spacing: 14) {

                LottieView(fileName: "DeleteNotification", loopMode: .loop)
                    .frame(width: 180, height: 180)
                    .padding(.top, 8)

                Text(title)
                    .font(AppFont.semiBold(size: 18))
                    .foregroundStyle(Color.black.opacity(0.85))

                HStack(spacing: 14) {
                    MainAppButton(title: cancelTitle) {
                        onCancel()
                    }

                    SecondRedButton(title: confirmTitle) {
                        onConfirm()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .frame(maxWidth: 360)
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.18), radius: 18, x: 0, y: 10)
            )
            .padding(.horizontal, 24)
        }
        .transition(.opacity)
    }
}
