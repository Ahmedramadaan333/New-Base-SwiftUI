//
//  ShowTextLabelView.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 04/08/2025.
//


import SwiftUI

struct ShowTextLabelView: View {
    let title: String
    let text: String
    let height: CGFloat
    let radius: CGFloat
    let fontSize: CGFloat
    let leadingImage: Image?
    let trailingImage: Image?

    init(
        title: String,
        text: String,
        height: CGFloat = 44,
        radius: CGFloat = 16,
        fontSize: CGFloat = 14,
        leadingImage: Image? = nil,
        trailingImage: Image? = nil
    ) {
        self.title = title
        self.text = text
        self.height = height
        self.radius = radius
        self.fontSize = fontSize
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(AppFont.medium(size: fontSize))

            HStack(spacing: 8) {
                if let leadingImage = leadingImage {
                    leadingImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }

                Text(text)
                    .font(AppFont.regular(size: fontSize))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let trailingImage = trailingImage {
                    trailingImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
            .frame(height: height)
            .padding(.horizontal, 12)
            .background(Color.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(Color.primaryMain.opacity(0.7), lineWidth: 1)
            )
            .cornerRadius(radius)
        }
        .padding(.horizontal)
    }
}

//struct ShowTextLabelView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack(spacing: 0
//        ) {
//            ShowTextLabelView(
//                title: "Username",
//                text: "ahmed.123"
//            )
//
//            ShowTextLabelView(
//                title: "Phone",
//                text: "123456789",
//                isPhone: true
//            )
//
//            ShowTextLabelView(
//                title: "Weight",
//                text: "75",
//                unitSuffix: "kg"
//            )
//
//            ShowTextLabelView(
//                title: "Email",
//                text: "example@email.com",
//                leadingImage: Image(systemName: "envelope"),
//                trailingImage: Image(systemName: "checkmark.circle")
//            )
//        }
//        .previewLayout(.sizeThatFits)
//        .padding()
//    }
//}
