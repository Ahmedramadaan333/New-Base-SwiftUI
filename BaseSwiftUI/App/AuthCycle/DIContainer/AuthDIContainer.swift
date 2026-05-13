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
            getCountriesUseCase: makeGetCountriesUseCase()
        )
    }

    func makeVerificationCodeViewModel(phone: String, countryCode: String, type: AuthVerificationType) -> VerificationCodeViewModel {
        VerificationCodeViewModel(
            phone: phone,
            countryCode: countryCode,
            type: type,
            verifyCodeUseCase: makeVerifyCodeUseCase(),
            resendCodeUseCase: makeResendCodeUseCase(),
            changePhoneUseCase: makeChangePhoneUseCase()
        )
    }

    func makeCompleteRegisterDataViewModel(phone: String, countryCode: String) -> CompleteRegisterDataViewModel {
        CompleteRegisterDataViewModel(
            phone: phone,
            countryCode: countryCode,
            registerUseCase: makeRegisterUseCase()
        )
    }
}
