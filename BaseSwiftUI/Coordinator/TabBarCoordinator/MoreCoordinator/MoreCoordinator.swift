//
//  ProfileCoordinator.swift
//  CTF
//
//  Created by Ahmed Ramadan on 17/11/2025.
//


// MoreCoordinator.swift
import SwiftUI

@MainActor
final class MoreCoordinator: BaseCoordinator<MoreCoordinatorRoute> {
    @Published var modalRoute: MoreModalRoute?

    @ViewBuilder
    func destination(for route: MoreCoordinatorRoute) -> some View {
        switch route {
        case .profile:
            ShowProfileView()
        case .settings:
            SettingsView()
        case .about:
            AppInfoView(kind: .aboutApp)
        case .privacy:
            AppInfoView(kind: .privacy)
        case .verfiyOldPhoneNumber:
            VerificationCodeView(phone: UserDefaults.user?.phone ?? "", countryCode: UserDefaults.user?.countryCode ?? "", type: .sendSmsToCurrentPhone)
        case .verifyNewPhoneNumber(let phone, let countryCode):
            VerificationCodeView(
                phone: phone,
                countryCode: countryCode,
                type: .verifyNewPhone
            )
        case .changePhoneNumber:
            ChangePhoneView()
        case .editProfile:
            EditProfileView()
        }
    }

    func show(_ route: MoreCoordinatorRoute) {
        path.append(route)
    }

    func present(_ modal: MoreModalRoute) {
        modalRoute = modal
    }

    func dismissModal() {
        modalRoute = nil
    }
}
