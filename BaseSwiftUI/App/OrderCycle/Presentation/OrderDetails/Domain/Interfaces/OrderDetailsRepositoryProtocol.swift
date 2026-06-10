//
//  OrderDetailsRepositoryProtocol.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation

protocol OrderDetailsRepositoryProtocol {
    func getOrderDetails(id: Int) async throws -> OrderDetailsData?
}
