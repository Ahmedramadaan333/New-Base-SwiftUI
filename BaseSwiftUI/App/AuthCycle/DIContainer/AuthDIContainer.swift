//
//  AuthDIContainer.swift
//  BaseSwiftUI
//

import Foundation

final class AuthDIContainer {

    // MARK: - Repository

    func makeAuthRepository() -> AuthRepositoryProtocol {
        AuthRepository()
    }

    // MARK: - Use Cases

    func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(repository: makeAuthRepository())
    }

    func makeValidateLoginFieldsUseCase() -> ValidateLoginFieldsUseCase {
        ValidateLoginFieldsUseCase()
    }

    func makeValidateRegisterFieldsUseCase() -> ValidateRegisterFieldsUseCase {
        ValidateRegisterFieldsUseCase()
    }

    func makeValidateVerificationFieldsUseCase() -> ValidateVerificationFieldsUseCase {
        ValidateVerificationFieldsUseCase()
    }

    func makeVerifyCodeUseCase() -> VerifyCodeUseCase {
        VerifyCodeUseCase(repository: makeAuthRepository())
    }

    func makeRegisterUseCase() -> RegisterUseCase {
        RegisterUseCase(repository: makeAuthRepository())
    }

    func makeResendCodeUseCase() -> ResendCodeUseCase {
        ResendCodeUseCase(repository: makeAuthRepository())
    }

    func makeGetCountriesUseCase() -> GetCountriesUseCase {
        GetCountriesUseCase(repository: makeAuthRepository())
    }

    func makeChangePhoneUseCase() -> ChangePhoneUseCase {
        ChangePhoneUseCase(repository: makeAuthRepository())
    }

    // MARK: - ViewModels

    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(
            loginUseCase: makeLoginUseCase(),
            getCountriesUseCase: makeGetCountriesUseCase(),
            validateFieldsUseCase: makeValidateLoginFieldsUseCase()
        )
    }

    func makeVerificationCodeViewModel(phone: String, countryCode: String, type: AuthVerificationType) -> VerificationCodeViewModel {
        VerificationCodeViewModel(
            phone: phone,
            countryCode: countryCode,
            type: type,
            verifyCodeUseCase: makeVerifyCodeUseCase(),
            resendCodeUseCase: makeResendCodeUseCase(),
            changePhoneUseCase: makeChangePhoneUseCase(),
            validateFieldsUseCase: makeValidateVerificationFieldsUseCase()
        )
    }

    func makeCompleteRegisterDataViewModel(phone: String, countryCode: String) -> CompleteRegisterDataViewModel {
        CompleteRegisterDataViewModel(
            phone: phone,
            countryCode: countryCode,
            registerUseCase: makeRegisterUseCase(),
            validateFieldsUseCase: makeValidateRegisterFieldsUseCase()
        )
    }
}
