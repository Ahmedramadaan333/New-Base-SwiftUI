//
//  SettingsToggleRow.swift
//  CTF
//
//  Created by Ahmed Ramadan on 04/12/2025.
//


import SwiftUI

struct SettingsToggleRow: View {
    let title: String
    let imageName: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
         
            Image(imageName)
                .frame(width: 24, height: 24)
            Text(title)
                .font(AppFont.regular(size: 14))

            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .frame(width: 52)
     
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .contentShape(Rectangle())
    }
}
