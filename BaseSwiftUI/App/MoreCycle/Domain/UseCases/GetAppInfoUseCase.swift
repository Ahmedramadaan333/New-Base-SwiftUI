//
//  GetAppInfoUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class GetAppInfoUseCase {

    private let repository: MoreRepositoryProtocol

    init(repository: MoreRepositoryProtocol) {
        self.repository = repository
    }

    func executeAboutApp() async throws -> String? {
        try await repository.getAboutApp()
    }

    func executeTerms() async throws -> String? {
        try await repository.getTerms()
    }

    func executePrivacy() async throws -> String? {
        try await repository.getPrivacy()
    }
}
