//
//  LoginView.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @EnvironmentObject var authCoordinator: AuthCoordinator

    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {

            VStack(spacing: 0) {
//                HeaderView()
//                    .frame(height: 220)
//                    .ignoresSafeArea(edges: .top)

                ZStack(alignment: .bottom) {
                    Color.backgroundView
                        .ignoresSafeArea(edges: .bottom)

                    ScrollView {
                        VStack(alignment: .leading ,spacing: 8) {

                            VStack(alignment: .leading, spacing: 8) {
                                Text("login_title".localized)
                                    .font(AppFont.bold(size: 18))

                                Text("login_description".localized)
                                    .font(AppFont.semiBold(size: 14))
                                    .foregroundColor(.secondary)
                            }
                            .padding(16)

                            VStack(alignment: .leading, spacing: 8) {
//                                PhoneTextView(
//                                    title: "Phone Number".localized,
//                                    placeHolder: "Please enter your phone number".localized,
//                                    phone: $viewModel.phone.value,
//                                    selectedCountry: $viewModel.selectedCountry,
//                                    hasError: viewModel.phone.hasError,
//                                    errorMessage: viewModel.phone.error,
//                                    items: viewModel.countries,
//                                    height: 50
//                                ).padding(16)


                                
                                AppTextFieldView(type: NameFieldCase(), textValue: $viewModel.name)

                                AppTextFieldView(type: PasswordFieldCase(), textValue: $viewModel.password)

                                AppTextFieldView(
                                    type: ConfirmPasswordFieldCase(password: viewModel.password),
                                    textValue: $viewModel.confirmPassword
                                )

                                VStack {
                                    MainAppButton(
                                        title: "login_title".localized,
                                        action: {
                                            viewModel.login()
                                        }
                                    )
                                }
                                .padding(8)
                            }
                            .padding(4)

                            HStack {
                                Spacer()
                                Button {
                                    authCoordinator.continueAsGuest()
                                } label: {
                                    Text("guest_login_tilte".localized)
                                        .font(AppFont.semiBold(size: 14))
                                        .foregroundColor(.primaryMain)
                                        .underline(color: .primaryMain)
                                }
                                Spacer()
                            }
                            .padding(.top, 4)

                            Spacer(minLength: 80)
                    
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 40)
                    }

                    Button {
                        authCoordinator.present(.language)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "globe")
                                .foregroundColor(.primaryMain)
                            Text("language_title".localized)
                                .font(AppFont.semiBold(size: 14))
                                .foregroundColor(.primaryMain)
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(Color.cardBackground)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule().stroke(Color.black.opacity(0.1), lineWidth: 1)
                        )
                    }
                    .padding(.bottom, 32)
                }
            }
        }
        .alert(for: viewModel)
        .loader(for: viewModel)
        .onAppear {
            if viewModel.countries.isEmpty {
                viewModel.getCountries()
            }
        }
        .onReceive(viewModel.$isLoginSuccess) { isSuccess in
            if isSuccess,
               let phone = viewModel.loginModel?.phone,
               let countryCode = viewModel.loginModel?.countryCode {
                authCoordinator.push(.verification(phone: phone, countryCode: countryCode))
            }
        }
        .onDisappear {
            print("LoginView disappeared")
        }
    }

}

 struct HeaderView: View {
    var body: some View {
        Image(.back)
            .resizable()
            .scaledToFill()
    }
}
