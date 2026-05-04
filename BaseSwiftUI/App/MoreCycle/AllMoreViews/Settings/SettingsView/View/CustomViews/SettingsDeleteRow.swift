//
//  SettingsDeleteRow.swift
//  CTF
//
//  Created by Ahmed Ramadan on 04/12/2025.
//

import SwiftUI

struct SettingsDeleteRow: View {
    let title: String
    let imageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
            Spacer()
                Image(imageName)
                    .renderingMode(.template)
                    .foregroundColor(.red)
                Text(title)
                    .font(AppFont.regular(size: 14))
                    .foregroundColor(.red)

            Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 50)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

