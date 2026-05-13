//
//  GetCountriesUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class GetCountriesUseCase {

    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [CountriesDataModel]? {
        try await repository.getCountries()
    }
}
