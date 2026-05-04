//
//  MoreItemView.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 04/08/2025.
//

import SwiftUI

struct MoreItemView: View {
    var action: () -> Void
    var imageName: String
    var titleName: String
    var titleColor: Color
    var showChevron: Bool

    var body: some View {
        Button(action: action) {
            HStack {

                Image(imageName)
                    .frame(width: 24, height: 24)

                Text(titleName)
                    .font(AppFont.regular(size: 14))
                    .foregroundColor(titleColor)

                Spacer()
                if showChevron {
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 14, weight: .medium))
                } else {
              
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 50)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 10.0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
