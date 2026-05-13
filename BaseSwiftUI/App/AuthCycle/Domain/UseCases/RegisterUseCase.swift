//
//  RegisterUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class RegisterUseCase {

    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }

    func execute(model: UserRegisterModel) async throws -> BaseResponse<User> {
        try await repository.register(model: model)
    }
}
