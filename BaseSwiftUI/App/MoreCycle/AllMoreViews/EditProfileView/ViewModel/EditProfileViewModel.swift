//
//  EditProfileViewModel.swift
//  BaseSwiftUI
//

import Foundation
import Combine

final class EditProfileViewModel: BaseViewModel {

    @Published var user: User?
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var imageData: Data?

    // errors
    @Published var nameError: String = ""

    // output
    @Published var isUpdateSuccess = false

    // MARK: - Dependencies

    private let editProfileUseCase: EditProfileUseCase

    // MARK: - Init

    init(editProfileUseCase: EditProfileUseCase) {
        self.editProfileUseCase = editProfileUseCase
        super.init()
        bindLiveValidation()
    }

    func loadFromUserDefaults() {
        let currentUser = UserDefaults.user
        self.user = currentUser
        self.name = currentUser?.name ?? ""
        self.email = currentUser?.email ?? ""
    }
}

// MARK: - Live validation
extension EditProfileViewModel {

    private func bindLiveValidation() {
        $name
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.liveValidateName(value)
            }
            .store(in: &cancellables)
    }

    func liveValidateName(_ value: String) {
        nameError = ""
        do {
            _ = try AuthValidationService.validate(name: value)
        } catch let error as AuthValidationError {
            if case .emptyName = error { return }
            nameError = error.localizedDescription
        } catch {
            emitError(error)
        }
    }
}

extension EditProfileViewModel {

    func submit() {
        nameError = ""

        do {
            _ = try AuthValidationService.validate(name: name)

            let model = UserRegisterModel(
                imageData: imageData, name: name,
                email: email
            )

            updateProfile(model: model)

        } catch let error as AuthValidationError {
            emitError(error)
        } catch {
            emitError(error)
        }
    }

    private func updateProfile(model: UserRegisterModel) {
        Task {
            startLoading()
            defer { stopLoading() }

            do {
                let response = try await editProfileUseCase.execute(model: model)
                emitSuccess(response.message)
                self.user = response.data
                self.isUpdateSuccess = true
                UserDefaults.user = response.data
            } catch {
                emitError(error)
            }
        }
    }
}
