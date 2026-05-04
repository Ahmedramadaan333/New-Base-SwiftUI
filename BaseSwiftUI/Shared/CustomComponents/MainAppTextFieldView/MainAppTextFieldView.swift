//
//  MainAppTF.swift
//  Proffer
//
//  Created by Ahmed Ramadan on 15/02/2024.
//

import SwiftUI
import UIKit

struct MainAppTextFieldView: View {
    @Binding var text: String
    @Binding var forceValidate: Bool
    let title: String
    let placeHolder: String
    let submitLabel: SubmitLabel
    let keyboardType: UIKeyboardType
    let titleSize: CGFloat
    let height: CGFloat
    let radius: CGFloat
    let isPhone: Bool
    let unitSuffix: String?
    let leadingImage: Image?
    let trailingImage: Image?

    let isSecure: Bool
    let hasError: Bool
    let errorMessage: String

    @State private var isPasswordVisible = false
    @FocusState private var isFocused: Bool

    private var borderColor: Color {
        if hasError {
            return .red
        } else if !text.isEmpty && !hasError && !isFocused {
            return .primaryMain
        } else {
            return .gray
        }
    }

    init(
        text: Binding<String>,
        forceValidate: Binding<Bool> = .constant(true),
        title: String,
        placeHolder: String,
        submitLabel: SubmitLabel,
        keyboardType: UIKeyboardType,
        titleSize: CGFloat = 14,
        height: CGFloat = 50,
        radius: CGFloat = 16,
        isPhone: Bool = false,
        unitSuffix: String? = nil,
        leadingImage: Image? = nil,
        trailingImage: Image? = nil,
        isSecure: Bool = false,
        hasError: Bool = false,
        errorMessage: String = ""
    ) {
        self._text = text
        self._forceValidate = forceValidate
        self.title = title
        self.placeHolder = placeHolder
        self.submitLabel = submitLabel
        self.keyboardType = keyboardType
        self.titleSize = titleSize
        self.height = height
        self.radius = radius
        self.isPhone = isPhone
        self.unitSuffix = unitSuffix
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.isSecure = isSecure
        self.hasError = hasError
        self.errorMessage = errorMessage
    }

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(title)
                    .font(AppFont.medium(size: 14))

                Spacer()
            }

            HStack(spacing: 8) {
                if let leadingImage = leadingImage {
                    leadingImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }

                if isPhone {
                    Text("+20")
                }

                if isSecure {
                    Group {
                        if isPasswordVisible {
                            CustomTextField(
                                text: $text,
                                placeholder: placeHolder,
                                keyboardType: keyboardType,
                                submitLabel: submitLabel,
                                isSecure: false
                            )
                            .frame(maxWidth: .infinity)

                        } else {
                            CustomTextField(
                                text: $text,
                                placeholder: placeHolder,
                                keyboardType: keyboardType,
                                submitLabel: submitLabel,
                                isSecure: true
                            )
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(height: height)
                } else {
                    CustomTextField(
                        text: $text,
                        placeholder: placeHolder,
                        keyboardType: keyboardType,
                        submitLabel: submitLabel,
                        isSecure: false
                    )
                    .frame(height: height)
                    .frame(maxWidth: .infinity)

                }

                if let unit = unitSuffix, !unit.isEmpty {
                    Text(unit)
                        .foregroundColor(.gray)
                        .font(AppFont.regular(size: 12))
                }

                if isSecure {
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .resizable()
                            .frame(width: 20, height: 16)
                            .foregroundColor(.gray)
                    }
                } else if let trailingImage = trailingImage {
                    trailingImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.horizontal)
            .frame(height: height)
            .background(Color.white)
            .cornerRadius(radius)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(borderColor, lineWidth: 0.5)
            )

            if hasError {
                HStack {
                    Text(errorMessage)
                        .minimumScaleFactor(0.9)
                        .padding(.leading, 5)
                        .foregroundStyle(Color.red)
                        .font(AppFont.regular(size: 12))

                    Spacer()
                }
            }
        }
        .padding(0)
    }
}



struct MainAppTF_Previews: PreviewProvider {
    @State static var sampleText: String = ""
    @State static var shouldValidate: Bool = true

    static var previews: some View {
        MainAppTextFieldView(
            text: $sampleText,
            forceValidate: $shouldValidate,
            title: "Phone Number",
            placeHolder: "Enter your number",
            submitLabel: .done,
            keyboardType: .phonePad,
            titleSize: 14,
            height: 56,
            radius: 12,
            isPhone: false,
            unitSuffix: "",
            leadingImage: Image(systemName: "phone.fill"),
            trailingImage: Image(systemName: "checkmark.circle")
        )
        .previewLayout(.sizeThatFits)
    }
}

