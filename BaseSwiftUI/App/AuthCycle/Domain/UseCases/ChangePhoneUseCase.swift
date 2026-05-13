//
//  ChangePhoneUseCase.swift
//  BaseSwiftUI
//
//  Groups all 4 change-phone operations.
//

import Foundation

final class ChangePhoneUseCase {

    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }

    func executeSendSmsToCurrentPhone() async throws -> BaseResponse<User> {
        try await repository.sendSmsToCurrentPhone()
    }

    func executeSendSmsToNewPhone(phone: String, countryCode: String) async throws -> BaseResponse<User> {
        try await repository.sendSmsToNewPhone(phone: phone, countryCode: countryCode)
    }

    func executeVerifyCurrentPhone(code: String) async throws -> BaseResponse<User> {
        try await repository.verifyCurrentPhone(code: code)
    }

    func executeVerifyNewPhone(phone: String, countryCode: String, code: String) async throws -> BaseResponse<User> {
        try await repository.verifyNewPhone(phone: phone, countryCode: countryCode, code: code)
    }
}
