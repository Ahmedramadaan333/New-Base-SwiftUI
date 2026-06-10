//
//  MoreViewModel.swift
//  BaseSwiftUI
//

import Foundation

class MoreViewModel: BaseViewModel {

    @Published var sections: [AnyMoreSection] = []
    @Published var signOutSuccessMessage: String?

    var onLogout: VoidCompletion?

    // MARK: - Dependencies

    private let signOutUseCase: SignOutUseCase

    // MARK: - Init

    init(signOutUseCase: SignOutUseCase) {
        self.signOutUseCase = signOutUseCase
        super.init()
    }

    func configureSections(
        isLoggedIn: Bool,
        navigate: @escaping (MoreRowID) -> Void,
        logout: @escaping () -> Void
    ) {
        if isLoggedIn {
            sections = MoreSectionsFactory.userSections(
                navigate: navigate,
                logout: logout
            )
        } else {
            sections = MoreSectionsFactory.guestSections(
                navigate: navigate
            )
        }
    }

    func signOut() {
        Task { [weak self] in
            guard let self else { return }

            startLoading()
            defer { stopLoading() }

            do {
                let response = try await signOutUseCase.execute()
                await MainActor.run {
                    self.signOutSuccessMessage = response.message
                    self.emitSuccess(response.message)
                    UserDefaults.isLogin = false
                    UserDefaults.user = nil
                    UserDefaults.accessToken = nil
                }
            } catch {
                self.emitError(error)
            }
        }
    }
}
