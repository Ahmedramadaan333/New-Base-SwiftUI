//
//  VerifyCodeUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class VerifyCodeUseCase {

    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }

    func executeLogin(phone: String, code: String, countryCode: String) async throws -> BaseResponse<User> {
        try await repository.verifyUserLogin(phone: phone, code: code, countryCode: countryCode)
    }

    func executeVerifyCurrentPhone(code: String) async throws -> BaseResponse<User> {
        try await repository.verifyCurrentPhone(code: code)
    }

    func executeVerifyNewPhone(phone: String, countryCode: String, code: String) async throws -> BaseResponse<User> {
        try await repository.verifyNewPhone(phone: phone, countryCode: countryCode, code: code)
    }
}
