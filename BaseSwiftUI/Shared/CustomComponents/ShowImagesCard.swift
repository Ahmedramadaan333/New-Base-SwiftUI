//
//  ShowImagesCard.swift
//  CTF
//
//  Created by Ahmed Ramadan on 22/12/2025.
//

import SwiftUI

struct ShowImagesCard: View {
    let title: String
    let images: [String]

    @State private var showViewer = false
    @State private var selectedIndex = 0

    private var validImages: [String] {
        images.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    var body: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 12) {

                Text(title)
                    .font(AppFont.bold(size: 16))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if validImages.isEmpty {
                    Text("-")
                        .font(AppFont.regular(size: 14))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    HStack(spacing: 10) {
                        ForEach(Array(validImages.prefix(4).enumerated()), id: \.offset) { i, url in
                            RemoteImageView(url: url)
                                .scaledToFill()
                                .frame(width: 56, height: 56)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedIndex = i
                                    showViewer = true
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .imageViewer(
            isPresented: $showViewer,
            urls: validImages,
            startIndex: min(selectedIndex, max(validImages.count - 1, 0))
        )
    }
}
