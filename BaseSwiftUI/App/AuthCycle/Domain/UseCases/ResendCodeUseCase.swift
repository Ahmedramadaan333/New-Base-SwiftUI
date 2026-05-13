//
//  ResendCodeUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class ResendCodeUseCase {

    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }

    func execute(phone: String, countryCode: String) async throws -> BaseResponse<User> {
        try await repository.resendCode(phone: phone, countryCode: countryCode)
    }
}
