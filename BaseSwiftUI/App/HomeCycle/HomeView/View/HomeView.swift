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

    @State private var selectedItem: MockPickerItem?
    @State private var showLoginPopup = false
    @State private var showSheet = false
    @State private var isOn = false
    var body: some View {
        BaseScreen(title: "") {
            VStack(spacing: 0) {

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        Button {
                            showSheet = true
                        } label: {
                            Text(selectedItem?.pickerTitle ?? "ttttestt")
                                       .foregroundStyle(.primaryMain)
                               }
                               .font(.largeTitle)
                               .foregroundColor(.red)

                        
                        
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
        .toolbar {
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("Notifications")
                } label: {
                    Image(systemName: "bell")
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                VStack {
                    Text("Status")
                        .font(.body)
                        .fixedSize()

                    Toggle("", isOn: $isOn)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle())
                        .scaleEffect(0.8)
                }
                .padding(.horizontal)
            }
        }
        
        .alert(for: viewModel)
        .loader(for: viewModel)
        
        .sheet(isPresented: $showSheet) {
            PickerSheetView(
                title: "general_picker_title",
                items: generalPickerItems,
                selected: $selectedItem
            )
        }

    }

    private func requireLogin(_ action: () -> Void) {
        if UserDefaults.isLogin {
            action()
        } else {
            showLoginPopup = true
        }
    }
    
    private var generalPickerItems: [MockPickerItem] {
        [
            MockPickerItem(
                pickerId: 1,
                pickerTitle: "Option 1",
                pickerImage: nil,
                pickerSlug: "opt_1"
            ),
            MockPickerItem(
                pickerId: 2,
                pickerTitle: "Option 2",
                pickerImage: nil,
                pickerSlug: "opt_2"
            ),
            MockPickerItem(
                pickerId: 3,
                pickerTitle: "Option 3",
                pickerImage: nil,
                pickerSlug: "opt_3"
            )
        ]
    }

}

struct MockPickerItem: GeneralPickerModel {

    var id: Int { pickerId }

    var pickerId: Int
    var pickerTitle: String
    var pickerImage: String?
    var pickerSlug: String?
}
