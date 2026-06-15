//
//  AuthRootView.swift
//  BaseSwiftUI
//

import SwiftUI

struct AuthRootView: View {
    @EnvironmentObject var authCoordinator: AuthCoordinator

    var body: some View {
        NavigationStack(path: $authCoordinator.path) {
            LoginView(viewModel: authCoordinator.container.makeLoginViewModel())
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case let .verification(phone, countryCode):
                        VerificationCodeView(
                            viewModel: authCoordinator.container.makeVerificationCodeViewModel(
                                phone: phone,
                                countryCode: countryCode,
                                type: .loginAsUser
                            )
                        )
                    }
                }
        }
        .sheet(item: $authCoordinator.modalRoute) { modal in
            switch modal {
            case .language:
                LanguageSheetView {
                    authCoordinator.dismissModal()
                }
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled(false)
                .presentationCornerRadius(40)
            }
        }
    }
}
