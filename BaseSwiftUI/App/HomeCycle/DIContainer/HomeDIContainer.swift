//
//  HomeDIContainer.swift
//  BaseSwiftUI
//

import Foundation

final class HomeDIContainer {

    // MARK: - Repository

    func makeHomeRepository() -> HomeRepositoryProtocol {
        HomeRepository()
    }

    // MARK: - Use Cases

    func makeGetHomeDataUseCase() -> GetHomeDataUseCase {
        GetHomeDataUseCase(repository: makeHomeRepository())
    }

    // MARK: - ViewModels

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(getHomeDataUseCase: makeGetHomeDataUseCase())
    }
}
