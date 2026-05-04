//
//  CompleteRegisterDataView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 24/11/2025.
//

import SwiftUI

struct CompleteRegisterDataView: View {
    
    // MARK: - Image picker state
    @StateObject private var imagePicker = ImagePickerCoordinator()
    @StateObject private var viewModel: CompleteRegisterDataViewModel
    @EnvironmentObject var authCoordinator: AuthCoordinator
    @EnvironmentObject var termsCoordinator: TermsCoordinator
    init(phone: String, countryCode: String) {
        _viewModel = StateObject(
            wrappedValue: CompleteRegisterDataViewModel(
                phone: phone,
                countryCode: countryCode
            )
        )
    }
    
    var body: some View {
        ZStack {
            LinearGradient.mainVertical.ignoresSafeArea()
            
            VStack(spacing: 0) {
                RegisterHeaderView()
                    .frame(height: 220)
                    .ignoresSafeArea(edges: .top)
                
                ScrollView {
                    VStack(alignment: .leading ,spacing: 8) {
                        
                        VStack(spacing: 8) {
                            Text("complete_register_title".localized)
                                .font(AppFont.bold(size: 18))
                            
                            Text("complete_register_description".localized)
                                .font(AppFont.semiBold(size: 14))
                                .foregroundColor(.black.opacity(0.6))
                        }
                        .padding(.top, 16)
                        
                        HStack {
                            Spacer()
                            VStack {
                                Text("attach_profile_image_title".localized)
                                    .font(AppFont.semiBold(size: 14))
                                    .foregroundColor(.black)
                                    .padding(.top, 8)
                                
                                ProfileImagePickerView(image: $imagePicker.selectedImage) {
                                    imagePicker.showPickerOptions()
                                }
                                .padding(.top, 4)
                            }
                            Spacer()
                        }
                        
                        MainAppTextFieldView(
                            text: $viewModel.name,
                            forceValidate: .constant(true),
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
                            forceValidate: .constant(false),
                            title: "email_title".localized,
                            placeHolder: "email_placholder".localized,
                            submitLabel: .next,
                            keyboardType: .emailAddress,
                            leadingImage: Image(.mail)
                        )
                        
                        HStack(alignment: .center, spacing: 12) {
                            Button {
                                viewModel.acceptTerms.toggle()
                            } label: {
                                Image(systemName: viewModel.acceptTerms ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.secondaryMain)
                                    .font(.system(size: 22))
                            }
                            
                            Button {
                                termsCoordinator.push(.terms)
                            } label: {
                                Text("accept_terms_and_conditions_title".localized)
                                    .foregroundColor(.secondary)
                                    .font(AppFont.regular(size: 14))
                            }
                            
                            Spacer()
                        }
                        
                        if !viewModel.termsError.isEmpty {
                            Text(viewModel.termsError)
                                .foregroundColor(.red)
                                .font(AppFont.regular(size: 12))
                                .padding(.leading, 4)
                        }
                        
                        MainAppButton(title: "confirm_title".localized) {
                            viewModel.submit()
                        }
                        .padding(.top, 24)
                        
                        Spacer(minLength: 80)
                    }
                    .padding(8)
                }
                .background(
                    Color.backgroundView
                        .clipShape(TopRoundedShape(radius: 24))
                        .ignoresSafeArea(edges: .bottom)
                )
            }
        }
        .navigationBarHidden(true)
        .alert(for: viewModel)
        .loader(for: viewModel)
        .imagePickerSheet(imagePicker)
        .onChange(of: imagePicker.selectedImage) { newImage in
            viewModel.imageData = newImage?.jpegData(compressionQuality: 0.7)
        }
        .onReceive(viewModel.$isRegisterSuccess) { success in
            if success {
                UserDefaults.user = viewModel.resultUser
                UserDefaults.accessToken = viewModel.resultUser?.token
                authCoordinator.loginSucceeded()
            }
        }
    }
}
