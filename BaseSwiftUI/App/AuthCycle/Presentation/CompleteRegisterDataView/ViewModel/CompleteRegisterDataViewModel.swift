//
//  CompleteRegisterDataViewModel.swift
//  BaseSwiftUI
//

import Foundation
import Combine

final class CompleteRegisterDataViewModel: BaseViewModel {

    // MARK: - Inputs
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var acceptTerms: Bool = false
    @Published var imageData: Data?

    @Published var phone: String
    @Published var countryCode: String

    // MARK: - Field Errors (live)
    @Published var nameError: String = ""
    @Published var termsError: String = ""

    // MARK: - Outputs
    @Published var isRegisterSuccess = false
    @Published var resultUser: User?

    // MARK: - Dependencies

    private let registerUseCase: RegisterUseCase

    // MARK: - Init

    init(phone: String, countryCode: String, registerUseCase: RegisterUseCase) {
        self.phone = phone
        self.countryCode = countryCode
        self.registerUseCase = registerUseCase
        super.init()
        bindLiveValidation()
    }
}

extension CompleteRegisterDataViewModel {

    func bindLiveValidation() {
        $name
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                self.liveValidateName(value)
            }
            .store(in: &cancellables)

        $acceptTerms
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                self.liveValidateTerms(value)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Live Field Validation
extension CompleteRegisterDataViewModel {

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

    func liveValidateTerms(_ accepted: Bool) {
        termsError = ""
        do {
            try AuthValidationService.validate(termesAgreed: accepted)
        } catch let error as AuthValidationError {
            termsError = error.localizedDescription
        } catch {
            emitError(error)
        }
    }
}

// MARK: - Submit (Full Form Validation)
extension CompleteRegisterDataViewModel {

    func submit() {
        nameError = ""
        termsError = ""

        do {
            _ = try AuthValidationService.validate(name: name)
            try AuthValidationService.validate(termesAgreed: acceptTerms)

            let model = UserRegisterModel(
                imageData: imageData,
                name: name,
                phone: phone,
                countryCode: countryCode,
                email: email,
                acceptTerms: acceptTerms
            )

            register(model: model)

        } catch let error as AuthValidationError {
            emitError(error)
        } catch {
            emitError(error)
        }
    }
}

// MARK: - Networking
extension CompleteRegisterDataViewModel {

    private func register(model: UserRegisterModel) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }

            do {
                let response = try await registerUseCase.execute(model: model)
                emitSuccess(response.message)
                self.resultUser = response.data
                self.isRegisterSuccess = true
            } catch {
                emitError(error)
            }
        }
    }
}
