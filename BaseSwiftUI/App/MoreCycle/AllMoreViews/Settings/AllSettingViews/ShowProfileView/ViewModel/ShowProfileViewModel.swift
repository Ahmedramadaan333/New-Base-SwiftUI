//
//  ShowProfileViewModel.swift
//  BaseSwiftUI
//

import Foundation

class ShowProfileViewModel: BaseViewModel {

    @Published private(set) var user: User?

    // MARK: - Dependencies

    private let showProfileUseCase: ShowProfileUseCase

    // MARK: - Init

    init(showProfileUseCase: ShowProfileUseCase) {
        self.showProfileUseCase = showProfileUseCase
        super.init()
    }
}

// MARK: - Networking
extension ShowProfileViewModel {

    func showProfile() {
        Task { [weak self] in
            guard let self else { return }

            self.startLoading()
            defer { self.stopLoading() }

            do {
                let data = try await showProfileUseCase.execute()
                guard let data else { return }
                await MainActor.run { self.user = data }
            } catch {
                self.emitError(error)
            }
        }
    }
}
