//
//  HomeRepositoryProtocol.swift
//  BaseSwiftUI
//

import Foundation

protocol HomeRepositoryProtocol {
    func getHomeData() async throws -> HomeData?
}
