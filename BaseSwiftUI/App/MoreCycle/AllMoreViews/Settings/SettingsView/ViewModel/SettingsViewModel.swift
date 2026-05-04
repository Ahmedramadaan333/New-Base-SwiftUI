//
//  SettingsViewModel.swift
//  CTF
//
//  Created by Ahmed Ramadan on 04/12/2025.
//


import Foundation

class SettingsViewModel: BaseViewModel {

    @Published var isNotificationsEnabled: Bool = true
    @Published var deleteSuccessMessage: String?

    init() {
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

            let endPoint = MoreEndPoint.changeNotificationsStatus()

            do {
                let response = try await getFullResponse(endPoint)
                guard let response = response else { return }

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

                let endPoint = MoreEndPoint.deleteAccount()

                do {
                    let response = try await getFullResponse(endPoint)
                    guard let response = response else { return }

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
