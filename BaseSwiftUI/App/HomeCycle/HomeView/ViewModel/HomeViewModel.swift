//
//  HomeViewModel.swift
//  BaseSwiftUI
//

import Foundation

class HomeViewModel: BaseViewModel {

    // MARK: - Published Data

    @Published private(set) var sliderImages: [ImageModel] = []
    @Published private(set) var categories: [CategoryModel] = []

    // MARK: - Dependencies

    private let getHomeDataUseCase: GetHomeDataUseCase

    // MARK: - Init

    init(getHomeDataUseCase: GetHomeDataUseCase) {
        self.getHomeDataUseCase = getHomeDataUseCase
        super.init()
        getHome()
    }
}

// MARK: - Networking

extension HomeViewModel {

    func getHome() {
        Task { [weak self] in
            guard let self else { return }
            self.startLoading()
            defer { self.stopLoading() }
            do {
                let data = try await self.getHomeDataUseCase.execute()
                await MainActor.run {
                    self.sliderImages = data?.images ?? []
                    self.categories   = data?.categories ?? []
                }
            } catch {
                self.emitError(error)
            }
        }
    }
}
