//
//  AppRadioOption.swift
//  CTF
//
//  Created by Ahmed Ramadan on 18/12/2025.
//


import SwiftUI

struct AppRadioOption: Identifiable, Hashable {
    let id: String        // القيمة اللي هترجع (مثلاً "new" / "scheduled")
    let title: String     // النص اللي هيتعرض للمستخدم
}

struct AppRadioGroupPicker: View {
    let title: String
    let options: [AppRadioOption]
    @Binding var selectionId: String
    var onChange: ((String) -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(AppFont.bold(size: 14))

            HStack(spacing: 24) {
                ForEach(options) { option in
                    radio(
                        title: option.title,
                        isSelected: selectionId == option.id
                    ) {
                        selectionId = option.id
                        onChange?(option.id)
                    }
                }
                Spacer()
            }
        }
    }

    private func radio(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)
                        .frame(width: 22, height: 22)

                    if isSelected {
                        Circle()
                            .fill(Color.primaryText)
                            .frame(width: 12, height: 12)
                    }
                }

                Text(title)
                    .font(AppFont.regular(size: 14))
                    .foregroundColor(isSelected ? .primaryText : .secondary)
            }
        }
        .buttonStyle(.plain)
    }
}
