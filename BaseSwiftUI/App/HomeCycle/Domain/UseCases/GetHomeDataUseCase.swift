//
//  GetHomeDataUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class GetHomeDataUseCase {

    private let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> HomeData? {
        try await repository.getHomeData()
    }
}
