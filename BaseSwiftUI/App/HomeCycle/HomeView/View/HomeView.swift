//
//  HomeView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 08/12/2025.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var homeCoordinator: HomeCoordinator
    @EnvironmentObject private var notificationsCoordinator: NotificationsCoordinator
    @EnvironmentObject private var appCoordinator: AppCoordinator

    @State private var showLoginPopup = false

    var body: some View {
        BaseScreen(title: "") {
            VStack(spacing: 0) {

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {

                        if !viewModel.sliderImages.isEmpty {
                            ImageSliderView(images: viewModel.sliderImages.map { ImageModel(image: $0.image ?? "") })
                                .frame(height: 180)
                                .padding(.top, 16)
                        }

                        if !viewModel.categories.isEmpty {
                            Text("sections_title".localized)
                                .font(AppFont.bold(size: 18))
                                .foregroundColor(.primaryText)
                                .padding(.horizontal, 16)

                            if let first = viewModel.categories.first {
                                MainServiceCard(
                                    title: first.name,
                                    subtitle: first.description,
                                    buttonTitle: "select_location_title".localized,
                                    imageURL: first.image,
                                    action: { requireLogin { } }
                                )
                                .padding(.horizontal, 16)
                            }

                            let others = Array(viewModel.categories.dropFirst())
                            if !others.isEmpty {
                                LazyVGrid(columns: [
                                    GridItem(.flexible(), spacing: 12),
                                    GridItem(.flexible())
                                ], spacing: 12) {
                                    ForEach(others) { category in
                                        SmallServiceCard(
                                            title: category.name,
                                            imageName: category.image,
                                            action: { requireLogin { } }
                                        )
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }

                        Spacer(minLength: 100)
                    }
                    .padding(.top, 8)
                }
                .refreshable { viewModel.getHome() }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                Image(.logo)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 35)
//            }
//
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    requireLogin {
//                        notificationsCoordinator.push(.notifications)
//                    }
//                } label: {
//                    Image(.notificationBell)
//                        .font(.system(size: 20, weight: .medium))
//                        .foregroundColor(.white)
//                        .padding(8)
//                }
//                .padding(.trailing, 16)
//            }
//        }
//        .overlay {
//            if showLoginPopup {
//                LoginRequiredPopup(
//                    isPresented: $showLoginPopup,
//                    title: "login_required_title".localized,
//                    buttonTitle: "login_title".localized,
//                    onLogin: {
//                        showLoginPopup = false
//                        appCoordinator.showAuth()
//                    }
//                )
//                .onTapGesture { }
//            }
//        }
        .alert(for: viewModel)
        .loader(for: viewModel)
    }

    private func requireLogin(_ action: () -> Void) {
        if UserDefaults.isLogin {
            action()
        } else {
            showLoginPopup = true
        }
    }

}


