//
//  AppInfoViewModel.swift
//  BaseSwiftUI
//

import Foundation

@MainActor
class AppInfoViewModel: BaseViewModel {

    @Published private(set) var content: String?

    private let kind: InfoScreenKind

    // MARK: - Dependencies

    private let getAppInfoUseCase: GetAppInfoUseCase

    // MARK: - Init

    init(kind: InfoScreenKind, getAppInfoUseCase: GetAppInfoUseCase) {
        self.kind = kind
        self.getAppInfoUseCase = getAppInfoUseCase
        super.init()
    }
}

// MARK: - Networking
extension AppInfoViewModel {

    func fetch() {
        Task { [weak self] in
            guard let self else { return }

            self.startLoading()
            defer { self.stopLoading() }

            do {
                let data: String?
                switch kind {
                case .aboutApp: data = try await getAppInfoUseCase.executeAboutApp()
                case .terms:    data = try await getAppInfoUseCase.executeTerms()
                case .privacy:  data = try await getAppInfoUseCase.executePrivacy()
                }
                guard let data else { return }
                content = data
            } catch {
                self.emitError(error)
            }
        }
    }
}
