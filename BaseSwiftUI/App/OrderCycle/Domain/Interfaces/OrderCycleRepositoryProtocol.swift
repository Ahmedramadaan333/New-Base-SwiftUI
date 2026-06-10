//
//  OrderCycleRepositoryProtocol.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation

protocol OrderCycleRepositoryProtocol {
    func getOrders() async throws -> OrderData?
}
