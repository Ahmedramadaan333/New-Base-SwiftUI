//
//  ExampleRepository.swift
//  BaseSwiftUI
//
//  Template: Concrete implementation of ExampleRepositoryProtocol.
//  Extends BaseRepository for built-in response handling.
//

import Foundation

final class ExampleRepository: BaseRepository, ExampleRepositoryProtocol {

    func getList() async throws -> [ExampleModel]? {
        try await request(ExampleEndPoint.getList())
    }
}
