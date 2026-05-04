//
//  BaseScreen.swift
//  CTF
//
//  Created by Ahmed Ramadan on 19/11/2025.
//

import SwiftUI

struct BaseScreen<Content: View>: View {
    let title: String
    let background: Color
    let showNavigationBar: Bool
    let contentPadding: EdgeInsets
    let content: () -> Content

    init(
        title: String,
        background: Color = .backgroundView,
        showNavigationBar: Bool = true,
        contentPadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.background = background
        self.showNavigationBar = showNavigationBar
        self.contentPadding = contentPadding
        self.content = content
    }

    var body: some View {
        let view = content()
            .padding(contentPadding)
            .background(background)

        if showNavigationBar {
            view.appNavigationBar(title)
        } else {
            view
        }
    }
}
