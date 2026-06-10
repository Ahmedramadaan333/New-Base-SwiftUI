//
//  CompleteRegisterDataViewModel.swift
//  BaseSwiftUI
//

import Foundation
import Combine

final class CompleteRegisterDataViewModel: BaseViewModel {

    // MARK: - Form Fields

    @Published var name: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var email: String = ""           // no validation required
    @Published var acceptTerms: Bool = false
    @Published var termsError: String = ""      // Bool field — no FieldState, plain error string
    @Published var imageData: Data?

    // MARK: - Pre-filled (injected, not editable)

    let phone: String
    let countryCode: String

    // MARK: - Outputs

    @Published var isRegisterSuccess = false
    @Published var resultUser: User?

    // MARK: - Dependencies

    private let registerUseCase: RegisterUseCase
    private let validateFieldsUseCase: ValidateRegisterFieldsUseCase

    // MARK: - Init

    init(
        phone: String,
        countryCode: String,
        registerUseCase: RegisterUseCase,
        validateFieldsUseCase: ValidateRegisterFieldsUseCase
    ) {
        self.phone = phone
        self.countryCode = countryCode
        self.registerUseCase = registerUseCase
        self.validateFieldsUseCase = validateFieldsUseCase
        super.init()
        bindLiveValidations()
    }

    // MARK: - Live Validation

    private func bindLiveValidations() {
        // Bool field — simple inline sink; no "silent on empty" guard needed.
        $acceptTerms
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] accepted in
                guard let self else { return }
                termsError = validateFieldsUseCase.liveValidate(termsAccepted: accepted) ?? ""
            }
            .store(in: &cancellables)
    }
}

// MARK: - Submit

extension CompleteRegisterDataViewModel {

    func submit() {
//        do {
//            try validateFieldsUseCase.validate(name: name)
//            try validateFieldsUseCase.validate(password: password)
//            try validateFieldsUseCase.validate(confirmPassword: confirmPassword, against: password)
//            try validateFieldsUseCase.validate(termsAccepted: acceptTerms)
//            let model = UserRegisterModel(
//                imageData: imageData,
//                name: name,
//                phone: phone,
//                countryCode: countryCode,
//                email: email.isEmpty ? nil : email,
//                password: password,
//                confirmPassword: confirmPassword,
//                acceptTerms: acceptTerms
//            )
//            register(model: model)
//        } catch let error as AuthValidationError {
//            emitError(error)
//        } catch {
//            emitError(error)
//        }
    }
}

// MARK: - Networking

private extension CompleteRegisterDataViewModel {

    func register(model: UserRegisterModel) {
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
