//
//  MoreRepository.swift
//  BaseSwiftUI
//

import Foundation

final class MoreRepository: BaseRepository, MoreRepositoryProtocol {

    func signOut() async throws -> BaseResponse<String> {
        try await getFullResponse(MoreEndPoint.signOut())
    }

    func showProfile() async throws -> User? {
        try await request(MoreEndPoint.showProfile())
    }

    func editProfile(model: UserRegisterModel) async throws -> BaseResponse<User> {
        try await getFullResponse(MoreEndPoint.EditProfile(model: model))
    }

    func changeNotificationsStatus() async throws -> BaseResponse<User> {
        try await getFullResponse(MoreEndPoint.changeNotificationsStatus())
    }

    func deleteAccount() async throws -> BaseResponse<String> {
        try await getFullResponse(MoreEndPoint.deleteAccount())
    }

    func getAboutApp() async throws -> String? {
        try await request(MoreEndPoint.getAboutApp())
    }

    func getTerms() async throws -> String? {
        try await request(MoreEndPoint.getTerms())
    }

    func getPrivacy() async throws -> String? {
        try await request(MoreEndPoint.getPrivacy())
    }
}
