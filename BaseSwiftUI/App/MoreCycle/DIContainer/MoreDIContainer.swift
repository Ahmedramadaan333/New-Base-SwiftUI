//
//  MoreDIContainer.swift
//  BaseSwiftUI
//

import Foundation

final class MoreDIContainer {

    // MARK: - Repository

    func makeMoreRepository() -> MoreRepositoryProtocol {
        MoreRepository()
    }

    // MARK: - Use Cases

    func makeSignOutUseCase() -> SignOutUseCase {
        SignOutUseCase(repository: makeMoreRepository())
    }

    func makeShowProfileUseCase() -> ShowProfileUseCase {
        ShowProfileUseCase(repository: makeMoreRepository())
    }

    func makeEditProfileUseCase() -> EditProfileUseCase {
        EditProfileUseCase(repository: makeMoreRepository())
    }

    func makeToggleNotificationsUseCase() -> ToggleNotificationsUseCase {
        ToggleNotificationsUseCase(repository: makeMoreRepository())
    }

    func makeDeleteAccountUseCase() -> DeleteAccountUseCase {
        DeleteAccountUseCase(repository: makeMoreRepository())
    }

    func makeGetAppInfoUseCase() -> GetAppInfoUseCase {
        GetAppInfoUseCase(repository: makeMoreRepository())
    }

    // MARK: - ViewModels

    func makeMoreViewModel() -> MoreViewModel {
        MoreViewModel(signOutUseCase: makeSignOutUseCase())
    }

    func makeShowProfileViewModel() -> ShowProfileViewModel {
        ShowProfileViewModel(showProfileUseCase: makeShowProfileUseCase())
    }

    func makeEditProfileViewModel() -> EditProfileViewModel {
        EditProfileViewModel(editProfileUseCase: makeEditProfileUseCase())
    }

    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(
            toggleNotificationsUseCase: makeToggleNotificationsUseCase(),
            deleteAccountUseCase: makeDeleteAccountUseCase()
        )
    }

    @MainActor func makeAppInfoViewModel(kind: InfoScreenKind) -> AppInfoViewModel {
        AppInfoViewModel(kind: kind, getAppInfoUseCase: makeGetAppInfoUseCase())
    }

    // MARK: - Auth Use Cases (used by ChangePhoneView which lives in MoreCycle)

    private func makeAuthRepository() -> AuthRepositoryProtocol {
        AuthRepository()
    }

    func makeGetCountriesUseCase() -> GetCountriesUseCase {
        GetCountriesUseCase(repository: makeAuthRepository())
    }

    func makeChangePhoneUseCase() -> ChangePhoneUseCase {
        ChangePhoneUseCase(repository: makeAuthRepository())
    }

    func makeChangePhoneViewModel() -> ChangePhoneViewModel {
        ChangePhoneViewModel(
            getCountriesUseCase: makeGetCountriesUseCase(),
            changePhoneUseCase: makeChangePhoneUseCase()
        )
    }
}
