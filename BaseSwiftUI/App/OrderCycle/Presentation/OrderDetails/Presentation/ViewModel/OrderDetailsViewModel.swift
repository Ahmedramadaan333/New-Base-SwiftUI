//
//  OrderDetailsViewModel.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 08/06/2026
//

import Foundation
import Combine

final class OrderDetailsViewModel: BaseViewModel {

    // MARK: - Published Data

    @Published private(set) var orderDetails: OrderDetailsData?

    // MARK: - Status Binding

    @Published var showLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?

    // MARK: - Dependencies

    private let getOrderDetailsUseCase: GetOrderDetailsUseCase
    private let orderId: Int

    // MARK: - Init

    init(orderId: Int, getOrderDetailsUseCase: GetOrderDetailsUseCase) {
        self.orderId = orderId
        self.getOrderDetailsUseCase = getOrderDetailsUseCase
        super.init()
        bindBaseViewModel()
        fetchOrderDetails()
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

extension OrderDetailsViewModel {

    func fetchOrderDetails() {
        Task { [weak self] in
            guard let self else { return }
            self.startLoading()
            defer { self.stopLoading() }
            do {
                let data = try await self.getOrderDetailsUseCase.execute(id: self.orderId)
                await MainActor.run {
                    self.orderDetails = data
                }
            } catch {
                self.emitError(error)
            }
        }
    }
}
