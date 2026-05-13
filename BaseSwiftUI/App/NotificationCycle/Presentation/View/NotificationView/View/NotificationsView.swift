//
//  NotificationsView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 29/12/2025.
//


import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var notificationsCoordinator: NotificationsCoordinator
    @StateObject var viewModel: NotificationsViewModel
    @State private var deleteAction: NotificationsDeleteAction?

    init(viewModel: NotificationsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        BaseScreen(title: "notifications_title".localized) {

            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 14) {

                    ForEach(viewModel.notifications, id: \.id) { item in
                        NotificationCard(
                            model: item,
                            onTap: { viewModel.open(item) },
                            onDelete: { deleteAction = .one(id: item.id ?? "")  }
                        )
                        .onAppear { viewModel.loadMoreIfNeeded(currentItem: item) }
                    }
                    .frame(maxWidth: .infinity)
                    .emptyPlaceholder(
                        isEmpty: viewModel.notifications.isEmpty,
                        style: .emptyNotifications
                    ) {
                        viewModel.load()
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 16)
            }
            
        }
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !viewModel.notifications.isEmpty {
                    Button {
                        deleteAction = .all
                    } label: {
                        Text("delete_notifications_title".localized)
                            .font(AppFont.semiBold(size: 14))
                            .foregroundStyle(Color.red)
                            .underline()
                    }
                }
            }
        }
        .overlay {
            if let action = deleteAction {
                DeleteConfirmPopup(
                    title: action.title,
                    confirmTitle: "delete_title".localized,
                    cancelTitle: "back_title".localized,
                    onConfirm: { handleDelete(action) },
                    onCancel: { deleteAction = nil }
                )
            }
        }
        .onAppear { viewModel.load() }
        .refreshable { await viewModel.refresh() }
        .loader(for: viewModel)
        .alert(for: viewModel)
    }

    private func handleDelete(_ action: NotificationsDeleteAction) {
        deleteAction = nil

        switch action {
        case .all:
            viewModel.deleteAllNotifications()
        case .one(let id):
            viewModel.deleteOne(id: id)
        }
    }

}


enum NotificationsDeleteAction: Identifiable, Hashable {
    case all
    case one(id: String)

    var id: String {
        switch self {
        case .all: return "all"
        case .one(let id): return "one-\(id)"
        }
    }

    var title: String {
        switch self {
        case .all:
            return "delete_all_confirm_title".localized
        case .one:
            return "delete_one_confirm_title".localized
        }
    }
}


 struct NotificationCard: View {

    let model: NotificationModel
    let onTap: () -> Void
    let onDelete: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .center, spacing: 12) {

                VStack(alignment: .leading, spacing: 8) {

                    HStack(spacing: 10) {
                        AppLogoCircle()

                        Text(model.title ?? "")
                            .font(AppFont.semiBold(size: 14))
                            .foregroundStyle(Color.primary)
                            .lineLimit(1)

                        Spacer()

                        Text(model.createdAt ?? "")
                            .font(AppFont.medium(size: 12))
                            .foregroundStyle(Color.secondary)
                    }

                    Text(model.body ?? "")
                        .font(AppFont.medium(size: 13))
                        .foregroundStyle(Color.secondary)
                        .lineLimit(2)
                }

                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.red)
                        .frame(width: 34, height: 34)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.cardBackground)
                    .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
            )
        }
        .buttonStyle(.plain)
    }
}

private struct AppLogoCircle: View {
    var body: some View {
        ZStack {
            Circle().fill(AppStyle.mainOrderGradient)
            Image(systemName: "bell.fill")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.white)
        }
        .frame(width: 44, height: 44)
    }
}
