//
//  LogoutPopUpView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 05/12/2025.
//


import SwiftUI

struct LogoutPopUpView: View {
    let onConfirm: () -> Void
    let onCancel: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.33)
                .ignoresSafeArea()
                .onTapGesture {
                    onCancel()
                }

            VStack(spacing: 20) {
                LottieView(fileName: "logout", loopMode: .loop)
                    .frame(width: 160, height: 160)

                Text("logout_message_title".localized)
                    .font(AppFont.medium(size: 14))
                    .lineLimit(2)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                HStack(spacing: 12) {
                    MainAppButton(title: "cancel_title".localized) {
                        onCancel()
                    }

                    Button {
                        onConfirm()
                    } label: {
                        Text("logout_confirm_title".localized)
                            .font(AppFont.medium(size: 14))
                            .foregroundColor(Color(.error))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                    }
                    .background(Color(.secondaryError))
                    .cornerRadius(12)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 4)
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 32)
            .frame(maxWidth: 360, maxHeight: 360)
            .background(Color.cardBackground)
            .cornerRadius(24)
            .shadow(radius: 16)
            .padding(.horizontal, 24)
        }
    }
}
