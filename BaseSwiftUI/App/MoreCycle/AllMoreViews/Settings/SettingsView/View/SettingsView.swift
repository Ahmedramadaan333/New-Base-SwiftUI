//
//  SettingsView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 04/12/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var moreCoordinator: MoreCoordinator
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @StateObject private var viewModel = SettingsViewModel()
    @State private var isShowingDeletePopup = false
    
    var body: some View {
        ZStack {
            BaseScreen(
                title: "settings_title".localized,
                background: .backgroundView
            ) {
                VStack {
                    VStack(spacing: 0) {
                        MoreItemView(
                            action: {
                                moreCoordinator.show(.profile)
                            },
                            imageName: MoreSectionsImages.profile.rawValue,
                            titleName: "show_profile_title".localized,
                            titleColor: .black,
                            showChevron: true
                        )
                        
                        Divider()
                        
                        MoreItemView(
                            action: {
                                moreCoordinator.show(.verfiyOldPhoneNumber)
                            },
                            imageName: MoreSectionsImages.editPhone.rawValue,
                            titleName: "edit_phone_title".localized,
                            titleColor: .black,
                            showChevron: true
                        )
                        
                        Divider()
                        
                        MoreItemView(
                            action: {
                                moreCoordinator.present(.changeLanguage)
                            },
                            imageName: MoreSectionsImages.changeLanguage.rawValue,
                            titleName: "change_language_title".localized,
                            titleColor: .black,
                            showChevron: true
                        )
                        
                        Divider()
                        
                        SettingsToggleRow(
                            title: "enable_notifications_title".localized,
                            imageName: MoreSectionsImages.changeNotification.rawValue,
                            isOn: $viewModel.isNotificationsEnabled
                        )
                        .onChange(of: viewModel.isNotificationsEnabled) { newValue in
                            viewModel.toggleNotifications(isOn: newValue)
                        }
                        
                        Divider()
                        
                        SettingsDeleteRow(
                            title: "delete_account_title".localized,
                            imageName: MoreSectionsImages.deleteAccount.rawValue,
                            action: {
                                isShowingDeletePopup = true
                            }
                        )
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.top, 16)
                    
                    Spacer()
                }
                .toolbar(.hidden, for: .tabBar)
            }
            .alert(for: viewModel)
            .loader(for: viewModel)
            
            if isShowingDeletePopup {
                DeleteAccountPopUpView(
                    onConfirm: {
                        isShowingDeletePopup = false
                        viewModel.deleteAccount()
                    },
                    onCancel: {
                        isShowingDeletePopup = false
                    }
                )
            }
        }
        .animation(.easeInOut, value: isShowingDeletePopup)
        .onReceive(viewModel.$deleteSuccessMessage) { message in
            guard message != nil else { return }
            appCoordinator.showAuth()
        }
    }
}
