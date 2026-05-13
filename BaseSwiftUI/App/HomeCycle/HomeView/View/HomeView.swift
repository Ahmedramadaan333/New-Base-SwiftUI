//
//  HomeView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 08/12/2025.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject private var homeCoordinator: HomeCoordinator
    @EnvironmentObject private var notificationsCoordinator: NotificationsCoordinator
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @State private var showLoginPopup = false
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        BaseScreen(title: "") {
            VStack(spacing: 0) {

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                      

                    }
                    .padding(.top, 8)
                }
                .refreshable { viewModel.getHome() }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        
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
