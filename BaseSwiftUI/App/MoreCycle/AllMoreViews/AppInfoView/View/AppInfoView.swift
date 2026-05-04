//
//  AboutView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 26/11/2025.
//


import SwiftUI


struct AppInfoView: View {
    private let kind: InfoScreenKind
    @StateObject private var viewModel: AppInfoViewModel
    
    init(kind: InfoScreenKind) {
        self.kind = kind
        _viewModel = StateObject(wrappedValue: AppInfoViewModel(kind: kind))
    }
    
    var body: some View {
        BaseScreen(title: kind.titleKey.localized) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .trailing, spacing: 16) {
                    if let html = viewModel.content {
                        HTMLText(html: html)
                            .font(AppFont.regular(size: 14))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 24)
                .padding(.top, 16)

            }
            .toolbar(.hidden, for: .tabBar)
        }
        .onAppear {
            viewModel.fetch()
        }
        .loader(for: viewModel)
        .alert(for: viewModel)
    }
}
