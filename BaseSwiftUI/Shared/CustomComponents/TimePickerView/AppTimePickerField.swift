//
//  AppTimePickerField.swift
//  CTF
//
//  Created by Ahmed Ramadan on 18/12/2025.
//


import SwiftUI

struct AppTimePickerField: View {
    let title: String
    let placeholder: String
    let iconSystemName: String

    @Binding var time: Date?

    var forceValidate: Bool
    var hasError: Bool
    var errorMessage: String

    var displayValue: (Date) -> String

    @State private var showPicker = false
    @State private var tempTime = Date()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(AppFont.semiBold(size: 14))

            Button {
                tempTime = time ?? Date()
                showPicker = true
            } label: {
                HStack(spacing: 10) {

                    Text(time.map(displayValue) ?? placeholder)
                        .font(AppFont.regular(size: 14))
                        .foregroundColor(time == nil ? .secondary : .primaryText)

                    Spacer()
                    Image(systemName: iconSystemName).foregroundColor(.secondary)
                }
                .padding(.horizontal, 12)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(hasError ? Color.red : Color.gray.opacity(0.25), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showPicker) {
                VStack(spacing: 16) {
                    Text(title)
                        .font(AppFont.bold(size: 16))
                        .padding(.top, 12)

                    DatePicker("", selection: $tempTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .padding(.horizontal, 12)

                    MainAppButton(title: "confirm_title".localized) {
                        time = tempTime
                        showPicker = false
                    }
                    .padding(.horizontal, 12)

                    Button { showPicker = false } label: {
                        Text("cancel_title".localized)
                            .font(AppFont.semiBold(size: 18))
                    }
                    .padding(.bottom, 16)
                }
                .presentationDetents([.medium])
            }

            if forceValidate && hasError {
                Text(errorMessage)
                    .font(AppFont.regular(size: 12))
                    .foregroundColor(.red)
            }
        }
    }
}
