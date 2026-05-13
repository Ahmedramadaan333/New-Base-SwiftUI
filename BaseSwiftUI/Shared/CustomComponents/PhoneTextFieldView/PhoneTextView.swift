//
//  PhoneTextView.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 30/07/2025.
//

import SwiftUI
import Kingfisher

struct PhoneTextView<Country: CountryCodeModel>: View {
    let title: String
    let placeHolder: String
    @Binding var phone: String
    @Binding var selectedCountry: Country?
    @Binding var forceValidate: Bool
    let hasError: Bool
    let errorMessage: String
    let items: [Country]
    let leadingIcon: Image?
    let height: CGFloat
    let radius: CGFloat
    init(
        title: String,
        placeHolder: String,
        phone: Binding<String>,
        selectedCountry: Binding<Country?>,
        forceValidate: Binding<Bool>,
        hasError: Bool,
        errorMessage: String = "",
        items: [Country],
        leadingIcon: Image? = nil,
        height: CGFloat = 40,
        radius: CGFloat = 16
    ) {
        self.title = title
        self.placeHolder = placeHolder
        self._phone = phone
        self._selectedCountry = selectedCountry
        self._forceValidate = forceValidate
        self.hasError = hasError
        self.errorMessage = errorMessage
        self.items = items
        self.leadingIcon = leadingIcon
        self.height = height
        self.radius = radius
    }

    @State private var showSheet = false

    private var borderColor: Color {
        if hasError {
            return .red
        } else if !phone.isEmpty {
            return .primaryMain
        } else {
            return .gray
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title.localized)
                .font(AppFont.medium(size: 14))

            HStack(spacing: 8) {
                // Leading icon
                if let leadingIcon {
                    leadingIcon
                        .resizable()
                        .frame(width: 20, height: 20)
                }

                // Phone text field
                CustomTextField(
                    text: $phone,
                    placeholder: placeHolder,
                    keyboardType: .phonePad,
                    submitLabel: .done
                )
                .frame(height: height)
                .frame(maxWidth: .infinity )

                // Country code + flag
                Button {
                    showSheet = true
                } label: {
                    HStack(spacing: 6) {
                        KFImage(URL(string: selectedCountry?.image ?? ""))
                            .placeholder {
                                Image(.logo)
                                    .resizable()
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 18)
                            .cornerRadius(4)

                        Text(selectedCountry?.countryCode ?? "+--")
                            .font(AppFont.regular(size: 14))

                            .foregroundColor(.primaryMain)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 8)
            .frame(height: height)
            .background(Color.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(borderColor, lineWidth: 0.8)
            )
            .cornerRadius(radius)

            if hasError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(AppFont.regular(size: 12))
            }
        }
//        .padding(.horizontal)
        .sheet(isPresented: $showSheet) {
            CountryPickerSheetView(
                title: "Select Country".localized,
                items: items,
                selected: $selectedCountry
            )
        }
        .onChange(of: selectedCountry) { _ in
            if selectedCountry != nil {
                forceValidate = false
            }
        }
    }
}
