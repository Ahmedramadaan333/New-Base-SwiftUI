//
//  OrderCycleViewModel.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation
import Combine

final class OrderCycleViewModel: BaseViewModel {

    // MARK: - Published Data

    @Published private(set) var orders: [OrderModel] = []
    @Published private(set) var orderId: Int?

    // MARK: - Status Binding

    @Published var showLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?

    // MARK: - Dependencies

    private let getOrdersUseCase: GetOrdersUseCase

    // MARK: - Init

    init(getOrdersUseCase: GetOrdersUseCase) {
        self.getOrdersUseCase = getOrdersUseCase
        super.init()
        bindBaseViewModel()
        fetchOrders()
    }

    // MARK: - Base Binding

    private func bindBaseViewModel() {
        isLoadingSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.showLoading = $0 }
            .store(in: &cancellables)

        errorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self else { return }
                errorMessage = error.localizedDescription
                showError = true
            }
            .store(in: &cancellables)

        $successMessage
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] in self?.emitSuccess($0) }
            .store(in: &cancellables)
    }
}

// MARK: - Networking

extension OrderCycleViewModel {

    func fetchOrders() {
        Task { [weak self] in
            guard let self else { return }
            self.startLoading()
            defer { self.stopLoading() }
            do {
                let data = try await self.getOrdersUseCase.execute()
                await MainActor.run {
                    self.orders = data?.orders ?? []
                }
            } catch {
                self.emitError(error)
            }
        }
    }
}
