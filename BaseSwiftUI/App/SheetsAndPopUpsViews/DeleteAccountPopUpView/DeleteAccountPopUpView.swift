//
//  DeleteAccountPopUpView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 04/12/2025.
//

import SwiftUI

struct DeleteAccountPopUpView: View {
    let onConfirm: () -> Void
    let onCancel: () -> Void

    var body: some View {
        ZStack {
            Color.gray.opacity(0.33)
                .ignoresSafeArea()
                .onTapGesture {
                    onCancel()
                }

            VStack(spacing: 20) {
                LottieView(fileName: "remove-profile", loopMode: .loop)
                    .frame(width: 180, height: 180)

                Text("delete_account_message_title".localized)
                    .font(AppFont.medium(size: 14))
                    .lineLimit(2)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                HStack(spacing: 12) {
                    MainAppButton(title: "cancel_title".localized) {
                        onCancel()
                    }

                    Button {
                        onConfirm()
                    } label: {
                        Text("confirm_delete_title".localized)
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
            .background(Color.white)
            .cornerRadius(24)
            .shadow(radius: 16)
            .padding(.horizontal, 24)
        }
    }
}
