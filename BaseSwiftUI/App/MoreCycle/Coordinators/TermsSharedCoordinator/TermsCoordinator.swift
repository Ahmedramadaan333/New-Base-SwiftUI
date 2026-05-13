//
//  TermsCoordinator.swift
//  BaseSwiftUI
//

import SwiftUI

final class TermsCoordinator: BaseCoordinator<TermsRoute> {
    let container = MoreDIContainer()
}

extension TermsCoordinator {
    @ViewBuilder
    func destination(for route: TermsRoute) -> some View {
        switch route {
        case .terms:
            AppInfoView(kind: .terms, viewModel: container.makeAppInfoViewModel(kind: .terms))
        }
    }
}
