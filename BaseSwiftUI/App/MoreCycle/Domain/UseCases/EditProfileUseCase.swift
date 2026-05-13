//
//  EditProfileUseCase.swift
//  BaseSwiftUI
//

import Foundation

final class EditProfileUseCase {

    private let repository: MoreRepositoryProtocol

    init(repository: MoreRepositoryProtocol) {
        self.repository = repository
    }

    func execute(model: UserRegisterModel) async throws -> BaseResponse<User> {
        try await repository.editProfile(model: model)
    }
}
