//
//  MoreRepositoryProtocol.swift
//  BaseSwiftUI
//

import Foundation

protocol MoreRepositoryProtocol {
    func signOut() async throws -> BaseResponse<String>
    func showProfile() async throws -> User?
    func editProfile(model: UserRegisterModel) async throws -> BaseResponse<User>
    func changeNotificationsStatus() async throws -> BaseResponse<User>
    func deleteAccount() async throws -> BaseResponse<String>
    func getAboutApp() async throws -> String?
    func getTerms() async throws -> String?
    func getPrivacy() async throws -> String?
}
