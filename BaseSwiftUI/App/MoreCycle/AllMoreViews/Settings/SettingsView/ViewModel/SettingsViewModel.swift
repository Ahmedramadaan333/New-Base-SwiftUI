//
//  SettingsViewModel.swift
//  BaseSwiftUI
//

import Foundation

class SettingsViewModel: BaseViewModel {

    @Published var isNotificationsEnabled: Bool = true
    @Published var deleteSuccessMessage: String?

    // MARK: - Dependencies

    private let toggleNotificationsUseCase: ToggleNotificationsUseCase
    private let deleteAccountUseCase: DeleteAccountUseCase

    // MARK: - Init

    init(
        toggleNotificationsUseCase: ToggleNotificationsUseCase,
        deleteAccountUseCase: DeleteAccountUseCase
    ) {
        self.toggleNotificationsUseCase = toggleNotificationsUseCase
        self.deleteAccountUseCase = deleteAccountUseCase
        super.init()
        isNotificationsEnabled = UserDefaults.user?.isNotify ?? true
    }

    func toggleNotifications(isOn: Bool) {
        isNotificationsEnabled = isOn
        changeNotificationsStatus()
    }

    private func changeNotificationsStatus() {
        Task { [weak self] in
            guard let self else { return }

            let oldValue = isNotificationsEnabled

            startLoading()
            defer { stopLoading() }

            do {
                let response = try await toggleNotificationsUseCase.execute()
                await MainActor.run {
                    self.isNotificationsEnabled = response.data?.isNotify ?? true
                    UserDefaults.user?.isNotify = response.data?.isNotify
                    self.emitSuccess(response.message)
                }
            } catch {
                await MainActor.run {
                    self.isNotificationsEnabled = oldValue
                    self.emitError(error)
                }
            }
        }
    }

    func deleteAccount() {
        Task { [weak self] in
            guard let self else { return }

            startLoading()
            defer { stopLoading() }

            do {
                let response = try await deleteAccountUseCase.execute()
                await MainActor.run {
                    UserDefaults.user = nil
                    UserDefaults.isLogin = false
                    UserDefaults.accessToken = nil
                    self.deleteSuccessMessage = response.message
                    self.emitSuccess(response.message)
                }
            } catch {
                await MainActor.run {
                    self.emitError(error)
                }
            }
        }
    }
}
