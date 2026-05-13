//
//  MoreCoordinator.swift
//  BaseSwiftUI
//

import SwiftUI

@MainActor
final class MoreCoordinator: BaseCoordinator<MoreCoordinatorRoute> {

    @Published var modalRoute: MoreModalRoute?

    let container = MoreDIContainer()

    @ViewBuilder
    func destination(for route: MoreCoordinatorRoute) -> some View {
        switch route {
        case .profile:
            ShowProfileView(viewModel: container.makeShowProfileViewModel())
        case .settings:
            SettingsView(viewModel: container.makeSettingsViewModel())
        case .about:
            AppInfoView(kind: .aboutApp, viewModel: container.makeAppInfoViewModel(kind: .aboutApp))
        case .privacy:
            AppInfoView(kind: .privacy, viewModel: container.makeAppInfoViewModel(kind: .privacy))
        case .verfiyOldPhoneNumber:
            VerificationCodeView(viewModel: AuthDIContainer().makeVerificationCodeViewModel(
                phone: UserDefaults.user?.phone ?? "",
                countryCode: UserDefaults.user?.countryCode ?? "",
                type: .sendSmsToCurrentPhone
            ))
        case .verifyNewPhoneNumber(let phone, let countryCode):
            VerificationCodeView(viewModel: AuthDIContainer().makeVerificationCodeViewModel(
                phone: phone,
                countryCode: countryCode,
                type: .verifyNewPhone
            ))
        case .changePhoneNumber:
            ChangePhoneView(viewModel: container.makeChangePhoneViewModel())
        case .editProfile:
            EditProfileView(viewModel: container.makeEditProfileViewModel())
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
