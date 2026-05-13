//
//  NotificationsViewModel.swift
//  BaseSwiftUI
//

import Foundation

@MainActor
final class NotificationsViewModel: BaseViewModel {

    @Published private(set) var notifications: [NotificationModel] = []

    private var page: Int = 1
    private var totalPages: Int = 1
    private var isPaging: Bool = false

    // MARK: - Dependencies

    private let getNotificationsUseCase: GetNotificationsUseCase
    private let deleteNotificationUseCase: DeleteNotificationUseCase

    // MARK: - Init

    init(
        getNotificationsUseCase: GetNotificationsUseCase,
        deleteNotificationUseCase: DeleteNotificationUseCase
    ) {
        self.getNotificationsUseCase = getNotificationsUseCase
        self.deleteNotificationUseCase = deleteNotificationUseCase
        super.init()
    }

    // MARK: - Public Interface

    func open(_ item: NotificationModel) {
        guard let payload = item.payload else { return }
        // TODO: Add app-specific routing based on payload.type.
        switch payload.type {
        case .adminMessage:
            break
        default:
            break
        }
    }

    func load() { Task { await fetch(reset: true, showLoader: true) } }
    func refresh() async { await fetch(reset: true, showLoader: false) }

    func loadMoreIfNeeded(currentItem: NotificationModel) {
        guard notifications.last?.id == currentItem.id else { return }
        guard page <= totalPages else { return }
        guard isPaging == false else { return }
        Task { await fetch(reset: false, showLoader: false) }
    }

    func deleteOne(id: String) {
        Task {
            let success = await deleteNotificationRequest(id: id)
            if success { notifications.removeAll { $0.id == id } }
        }
    }

    func deleteAllNotifications() {
        Task {
            let success = await deleteAllRequest()
            if success {
                notifications.removeAll()
                page = 1
                totalPages = 1
            }
        }
    }
}

private extension NotificationsViewModel {

    func fetch(reset: Bool, showLoader: Bool) async {
        if reset {
            page = 1
            totalPages = 1
        } else {
            isPaging = true
        }

        if showLoader { startLoading() }
        defer {
            if showLoader { stopLoading() }
            isPaging = false
        }

        do {
            let response = try await getNotificationsUseCase.execute(page: page)
            guard let response else { return }

            let newItems = response.data ?? []
            totalPages = response.pagination?.totalPages ?? 1

            if reset { notifications = newItems }
            else { notifications.append(contentsOf: newItems) }

            page += 1

        } catch {
            if Task.isCancelled { return }
            if let urlError = error as? URLError, urlError.code == .cancelled { return }
            emitError(error)
        }
    }

    func deleteNotificationRequest(id: String) async -> Bool {
        startLoading()
        defer { stopLoading() }

        do {
            let response = try await deleteNotificationUseCase.executeOne(id: id)
            emitSuccess(response.message)
            return true
        } catch {
            if Task.isCancelled { return false }
            if let urlError = error as? URLError, urlError.code == .cancelled { return false }
            emitError(error)
            return false
        }
    }

    func deleteAllRequest() async -> Bool {
        startLoading()
        defer { stopLoading() }

        do {
            let response = try await deleteNotificationUseCase.executeAll()
            emitSuccess(response.message)
            return true
        } catch {
            if Task.isCancelled { return false }
            if let urlError = error as? URLError, urlError.code == .cancelled { return false }
            emitError(error)
            return false
        }
    }
}
