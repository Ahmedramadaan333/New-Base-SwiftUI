//
//  MoreViewModel.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 31/07/2025.
//

import Foundation

class MoreViewModel: BaseViewModel {

    @Published var sections: [AnyMoreSection] = []
    @Published var signOutSuccessMessage: String?

    var onLogout: VoidCompletion?

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

            let endPoint = MoreEndPoint.signOut()

            do {
                let response = try await getFullResponse(endPoint)
                guard let response = response else { return }

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

