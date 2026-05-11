//
//  TermsCoordinator.swift
//  CTF
//
//  Created by Ahmed Ramadan on 25/11/2025.
//


import SwiftUI

final class TermsCoordinator: BaseCoordinator<TermsRoute> { }

extension TermsCoordinator {
    @ViewBuilder
    func destination(for route: TermsRoute) -> some View {
        switch route {
        case .terms:
            AppInfoView(kind: .terms )
        }
    }
}
