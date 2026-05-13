//
//  AuthRepository.swift
//  BaseSwiftUI
//

import Foundation

final class AuthRepository: BaseRepository, AuthRepositoryProtocol {

    func login(authModel: UserRegisterModel) async throws -> BaseResponse<User> {
        try await getFullResponse(AuthEndPoint.login(authModel: authModel))
    }

    func verifyUserLogin(phone: String, code: String, countryCode: String) async throws -> BaseResponse<User> {
        try await getFullResponse(AuthEndPoint.verifyUserLogin(phone: phone, code: code, countryCode: countryCode))
    }

    func register(model: UserRegisterModel) async throws -> BaseResponse<User> {
        try await getFullResponse(AuthEndPoint.verifyAndSignupAsUser(model: model))
    }

    func resendCode(phone: String, countryCode: String) async throws -> BaseResponse<User> {
        try await getFullResponse(AuthEndPoint.resendCode(phone: phone, countryCode: countryCode))
    }

    func getCountries() async throws -> [CountriesDataModel]? {
        try await request(AuthEndPoint.getCountries())
    }

    func sendSmsToCurrentPhone() async throws -> BaseResponse<User> {
        try await getFullResponse(AuthEndPoint.sendSmsToCurrentPhone())
    }

    func verifyCurrentPhone(code: String) async throws -> BaseResponse<User> {
        try await getFullResponse(AuthEndPoint.verifyCurrentPhone(code: code))
    }

    func sendSmsToNewPhone(phone: String, countryCode: String) async throws -> BaseResponse<User> {
        try await getFullResponse(AuthEndPoint.sendSmsToNewPhone(phone: phone, countryCode: countryCode))
    }

    func verifyNewPhone(phone: String, countryCode: String, code: String) async throws -> BaseResponse<User> {
        try await getFullResponse(AuthEndPoint.verifyNewPhone(phone: phone, countryCode: countryCode, code: code))
    }
}
