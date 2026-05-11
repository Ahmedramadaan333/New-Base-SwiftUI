//
//  MoreScreen.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 31/07/2025.
//

import SwiftUI
import Kingfisher

struct MoreScreen: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var moreCoordinator: MoreCoordinator
    @EnvironmentObject var termsCoordinator: TermsCoordinator
    @EnvironmentObject var notificationsCoordinator: NotificationsCoordinator

    @StateObject private var viewModel = MoreViewModel()
    @State private var isShowingLogoutPopup = false
    @State private var showLoginPopup = false

    private var isLoggedIn: Bool { UserDefaults.isLogin }

    var body: some View {
        ZStack(alignment: .top) {
            BaseScreen(
                title: "",
                background: .clear,
                showNavigationBar: false
            ) {
                VStack(spacing: 0) {

                    navBar
                        .padding(.top, 4)

                    VStack(spacing: 16) {
                        if isLoggedIn {
                            headerView
                                .padding(.top, -56)
                                .background(.clear)
                        }

                        ScrollView(showsIndicators: false) {
                            sectionsList
                                .padding(.top, 8)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 24)
                    .padding(.top, 8)
                    .offset(y: 16)
                }
            }
        }
        .background(Color.backgroundView.ignoresSafeArea())
        .onAppear { setupSections() }
        .onReceive(NotificationCenter.default.publisher(for: .isLoginChanged)) { _ in
            setupSections()
        }
        .alert(for: viewModel)
        .loader(for: viewModel)
        .onReceive(viewModel.$signOutSuccessMessage) { message in
            guard message != nil else { return }
            appCoordinator.showAuth()
        }
        .overlay {
            if isShowingLogoutPopup {
                LogoutPopUpView(
                    onConfirm: {
                        isShowingLogoutPopup = false
                        viewModel.signOut()
                    },
                    onCancel: {
                        isShowingLogoutPopup = false
                    }
                )
            }

            if showLoginPopup {
                LoginRequiredPopup(
                    isPresented: $showLoginPopup,
                    title: "login_required_title".localized,
                    buttonTitle: "login_title".localized
                ) {
                    showLoginPopup = false
                    appCoordinator.showAuth()
                }
            }
        }
        .animation(.easeInOut, value: isShowingLogoutPopup)
        .animation(.easeInOut, value: showLoginPopup)
    }

    private var navBar: some View {
        HStack {
            Spacer()

            Button {
                if isLoggedIn {
                    notificationsCoordinator.push(.notifications)
                } else {
                    showLoginPopup = true
                }
            } label: {
                Image(.notificationBell)
                    .frame(width: 36, height: 36)
            }
        }
        .padding(.horizontal, 16)
    }

    private var sectionsList: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.sections) { section in
                if !section.title.isEmpty {
                    HeaderTitleView(title: section.title)
                }

                VStack(spacing: 0) {
                    ForEach(section.items, id: \.stringId) { item in
                        MoreItemView(
                            action: item.action,
                            imageName: item.imageName,
                            titleName: item.title,
                            titleColor: item.titleColor,
                            showChevron: item.showChevron
                        )
                        Divider()
                    }
                }
                .background(Color.white)
                .cornerRadius(12)
            }
        }
    }

    private func setupSections() {
        viewModel.configureSections(
            isLoggedIn: isLoggedIn,
            navigate: { id in handleNavigation(for: id) },
            logout: { isShowingLogoutPopup = true }
        )

        viewModel.onLogout = { [weak appCoordinator] in
            appCoordinator?.showAuth()
        }
    }

    private func handleNavigation(for id: MoreRowID) {
        switch id {
        case .settings:
            moreCoordinator.show(.settings)

        case .terms:
            termsCoordinator.push(.terms)

        case .about:
            moreCoordinator.show(.about)

        case .privacy:
            moreCoordinator.show(.privacy)

        case .logout:
            isShowingLogoutPopup = true

        case .changeLanguage:
            moreCoordinator.present(.changeLanguage)

        case .login:
            appCoordinator.showAuth()
        }
    }

    private var headerView: some View {
        VStack(spacing: 12) {
            KFImage(URL(string: UserDefaults.user?.image ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                .shadow(radius: 4)

            Text(UserDefaults.user?.name ?? "")
                .font(AppFont.semiBold(size: 18))

            if let email = UserDefaults.user?.email, !email.isEmpty {
                Text(email)
                    .font(AppFont.regular(size: 12))
                    .foregroundColor(.gray)
            }

            Button {
                moreCoordinator.show(.editProfile)
            } label: {
                HStack(spacing: 8) {
                    Image(.editUser)
                    Text("edit_profile_title".localized)
                        .font(AppFont.regular(size: 14))
                }
                .foregroundColor(.primaryMain)
                .padding(.horizontal, 32)
                .padding(.vertical, 10)
                .frame(width: UIScreen.main.bounds.width * 0.6)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(LinearGradient.mainVertical, lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
        }
        .background(.clear)
    }
}

struct HeaderTitleView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(AppFont.regular(size: 14))
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .padding(.top, 4)
            Spacer()
        }
    }
}
