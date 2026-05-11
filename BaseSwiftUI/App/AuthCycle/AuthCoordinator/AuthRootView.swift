//
//  AuthRootView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 16/11/2025.
//

import SwiftUI

struct AuthRootView: View {
    @EnvironmentObject var authCoordinator: AuthCoordinator
    
    var body: some View {
        NavigationStack(path: $authCoordinator.path) {
            LoginView()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case let .verification(phone, countryCode):
                        VerificationCodeView(
                            phone: phone,
                            countryCode: countryCode, type: .loginAsUser
                            )
                    case let .completeRegisterData(phone, countryCode):
                        CompleteRegisterDataView(phone: phone, countryCode: countryCode)
                        
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
