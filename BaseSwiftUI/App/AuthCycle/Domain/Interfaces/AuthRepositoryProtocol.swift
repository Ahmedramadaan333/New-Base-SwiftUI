//
//  AuthRepositoryProtocol.swift
//  BaseSwiftUI
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(authModel: UserRegisterModel) async throws -> BaseResponse<User>
    func verifyUserLogin(phone: String, code: String, countryCode: String) async throws -> BaseResponse<User>
    func register(model: UserRegisterModel) async throws -> BaseResponse<User>
    func resendCode(phone: String, countryCode: String) async throws -> BaseResponse<User>
    func getCountries() async throws -> [CountriesDataModel]?
    func sendSmsToCurrentPhone() async throws -> BaseResponse<User>
    func verifyCurrentPhone(code: String) async throws -> BaseResponse<User>
    func sendSmsToNewPhone(phone: String, countryCode: String) async throws -> BaseResponse<User>
    func verifyNewPhone(phone: String, countryCode: String, code: String) async throws -> BaseResponse<User>
}
