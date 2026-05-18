//
//  EditProfileView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 07/12/2025.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    @StateObject private var imagePicker = ImagePickerCoordinator()
    @StateObject var viewModel: EditProfileViewModel
    @EnvironmentObject var moreCoordinator: MoreCoordinator

    init(viewModel: EditProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        BaseScreen(title: "edit_profile_title".localized) {
            VStack(spacing: 16) {
                
                ZStack(alignment: .bottomTrailing) {
                    if let selectedImage = imagePicker.selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.cardBackground, lineWidth: 3)
                            )
                            .shadow(radius: 4)
                    } else {
                        KFImage(URL(string: viewModel.user?.image ?? ""))
                            .placeholder {
                                Image(.user)
                                    .resizable()
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.cardBackground, lineWidth: 3)
                            )
                            .shadow(radius: 4)
                    }
                    
                    Button {
                        imagePicker.showPickerOptions()
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 26, height: 26)
                            .background(Color.cardBackground.clipShape(Circle()))
                    }
                    .offset(x: 4, y: 4)
                }
                .padding(.top, 8)

                
                MainAppTextFieldView(
                    text: $viewModel.name,
                    title: "username_title".localized,
                    placeHolder: "username_placholder".localized,
                    submitLabel: .next,
                    keyboardType: .default,
                    leadingImage: Image(.name),
                    hasError: !viewModel.nameError.isEmpty,
                    errorMessage: viewModel.nameError
                )
                
                MainAppTextFieldView(
                    text: $viewModel.email,
                    title: "email_title".localized,
                    placeHolder: "email_placholder".localized,
                    submitLabel: .done,
                    keyboardType: .emailAddress,
                    leadingImage: Image(.mail)
                )
                
                Spacer()
                
                MainAppButton(title: "confirm_title".localized) {
                    viewModel.submit()
                }
                .padding(.bottom, 8)
            }
            .onAppear {
                viewModel.loadFromUserDefaults()
            }
        }
        .imagePickerSheet(imagePicker)
        .onChange(of: imagePicker.selectedImage) { newImage in
            viewModel.imageData = newImage?.jpegData(compressionQuality: 0.7)
        }
        .onChange(of: viewModel.isUpdateSuccess) { newValue in
            moreCoordinator.pop()
        }
        .loader(for: viewModel)
        .alert(for: viewModel)
        .toolbar(.hidden, for: .tabBar)
    }
}
