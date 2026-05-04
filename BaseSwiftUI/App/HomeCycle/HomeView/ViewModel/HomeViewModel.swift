//
//  HomeViewModel.swift
//  CTF
//
//  Created by Ahmed Ramadan on 08/12/2025.
//

import Foundation
class HomeViewModel: BaseViewModel {
    
    // MARK: - Published Data
    
    @Published private(set) var sliderImages: [ImageModel] = []
    @Published private(set) var categories: [CategoryModel] = []
    
    
    // MARK: - Init
    
    required override init(responseHandler: ResponseHandler = DefaultResponseHandler()) {
        super.init(responseHandler: responseHandler)
        getHome()
    }
}

// MARK: - Networking

extension HomeViewModel {
    
    func getHome() {
        // TODO: Define your home endpoint and replace this stub.
        // Example:
        // Task { [weak self] in
        //     guard let self else { return }
        //     self.startLoading()
        //     defer { self.stopLoading() }
        //     do {
        //         let endpoint = HomeEndPoints.getHomeData()
        //         let response = try await self.getFullResponse(endpoint)
        //         await MainActor.run {
        //             self.sliderImages = response?.data?.images ?? []
        //             self.categories   = response?.data?.categories ?? []
        //         }
        //     } catch { self.emitError(error) }
        // }
    }
}
