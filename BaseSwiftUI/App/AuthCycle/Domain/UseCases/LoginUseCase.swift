//
//  LoginUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class LoginUseCase {

    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Execute -
    func execute(model: UserRegisterModel) async throws -> BaseResponse<User> {
        _ = try AuthValidationService.validate(phone: model.phone)
        _ = try AuthValidationService.validate(name: model.name)
        return try await repository.login(authModel: model)
    }
}
