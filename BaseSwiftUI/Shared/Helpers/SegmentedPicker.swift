//
//  SegmentedPicker.swift
//  CTF
//
//  Created by Ahmed Ramadan on 12/12/2025.
//


import SwiftUI

struct SegmentedPicker<Item: Hashable>: View {
    @Binding var selection: Item
    let items: [Item]
    let titleForItem: (Item) -> String

    var height: CGFloat = 44
    var cornerRadius: CGFloat = 20
    var containerCornerRadius: CGFloat = 24
    var containerColor: Color = .white
    var selectedBackground: AnyShapeStyle = AnyShapeStyle(LinearGradient.mainVertical)
    var selectedTextColor: Color = .white
    var unselectedTextColor: Color = Color(.secondaryLabel)
    var font: Font = AppFont.medium(size: 14)
    var horizontalPadding: CGFloat = 4
    var verticalPadding: CGFloat = 4

    @Namespace private var ns

    var body: some View {
        GeometryReader { geo in
            let totalWidth = max(0, geo.size.width)
            let availableWidth = max(0, totalWidth - horizontalPadding * 2)
            let count = max(1, items.count)
            let segWidth = availableWidth / CGFloat(count)
            let selectedIndex = items.firstIndex(of: selection) ?? 0

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: containerCornerRadius)
                    .fill(containerColor)

                if segWidth.isFinite && segWidth > 0 {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(selectedBackground)
                        .frame(
                            width: segWidth,
                            height: geo.size.height - verticalPadding * 2
                        )
                        .padding(.vertical, verticalPadding)
                        .padding(.leading, horizontalPadding + CGFloat(selectedIndex) * segWidth)
                        .matchedGeometryEffect(id: "selector", in: ns)
                        .animation(
                            .interactiveSpring(response: 0.35, dampingFraction: 0.7),
                            value: selectedIndex
                        )
                }

                HStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        let item = items[index]

                        Button {
                            guard selection != item else { return }
                            selection = item
                        } label: {
                            Text(titleForItem(item))
                                .font(font)
                                .frame(
                                    width: segWidth > 0 ? segWidth : nil,
                                    height: geo.size.height
                                )
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                                .foregroundColor(
                                    item == selection
                                    ? selectedTextColor
                                    : unselectedTextColor
                                )
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, horizontalPadding)
            }
        }
        .frame(height: height)
    }
}
