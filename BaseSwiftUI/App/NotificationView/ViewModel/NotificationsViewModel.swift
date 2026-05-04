//
//  NotificationsViewModel.swift
//  CTF
//
//  Created by Ahmed Ramadan on 29/12/2025.
//


import Foundation

@MainActor
final class NotificationsViewModel: BaseViewModel {

    @Published private(set) var notifications: [NotificationModel] = []

    private var page: Int = 1
    private var totalPages: Int = 1
    private var isPaging: Bool = false

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
            let endPoint = NotificationsEndPoints.getNotifications(page: page)
            let response = try await request(endPoint)
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
            let endPoint = NotificationsEndPoints.deleteNotification(id: id)
            let response = try await getFullResponse(endPoint)
            emitSuccess(response?.message ?? "")
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
            let endPoint = NotificationsEndPoints.deleteAll()
            let response = try await getFullResponse(endPoint)
            emitSuccess(response?.message ?? "")
            return true
        } catch {
            if Task.isCancelled { return false }
            if let urlError = error as? URLError, urlError.code == .cancelled { return false }
            emitError(error)
            return false
        }
    }
}
