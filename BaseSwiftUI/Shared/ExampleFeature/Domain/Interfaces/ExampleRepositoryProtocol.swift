//
//  ExampleRepositoryProtocol.swift
//  BaseSwiftUI
//
//  Template: Define the data contract your feature's use cases depend on.
//  Replace "Example" with your feature name throughout.
//

import Foundation

// TODO: Define the methods your feature needs from the network/data layer.
protocol ExampleRepositoryProtocol {
    func getList() async throws -> [ExampleModel]?
}
