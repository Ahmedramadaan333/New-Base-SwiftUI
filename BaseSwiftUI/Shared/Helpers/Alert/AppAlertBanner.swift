//
//  AppAlertBanner.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//


import SwiftUI

struct AppAlertBanner: View {
    let alert: AppAlert
    let onTap: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: alert.style.iconName)
                .font(.system(size: 20, weight: .semibold))
            
            VStack(alignment: .leading, spacing: 4) {
                if let title = alert.title, !title.isEmpty {
                                Text(title)
                                    .font(AppFont.bold(size: 12))
                            }
                            
                if let message = alert.message, !message.isEmpty {
                    Text(message)
                        .font(AppFont.semiBold(size: 14))
                        .lineLimit(3)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .background(alert.style.backgroundColor.opacity(0.95))
        .foregroundColor(.white)
        .cornerRadius(16)
        .shadow(radius: 12)
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .onTapGesture {
            onTap()
        }
    }
}
