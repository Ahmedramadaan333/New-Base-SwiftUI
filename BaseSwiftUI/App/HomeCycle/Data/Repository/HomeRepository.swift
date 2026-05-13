//
//  HomeRepository.swift
//  BaseSwiftUI
//

import Foundation

final class HomeRepository: BaseRepository, HomeRepositoryProtocol {

    func getHomeData() async throws -> HomeData? {
        try await request(HomeEndPoints.getHomeData())
    }
}
