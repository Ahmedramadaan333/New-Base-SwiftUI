//
//  AuthVerificationCodeView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 17/11/2025.
//

import SwiftUI

struct VerificationCodeView: View {
    @EnvironmentObject var authCoordinator: AuthCoordinator
    @EnvironmentObject var moreCoordinator: MoreCoordinator
    let onNeedRegister: (String, String) -> ((Void?))
    @StateObject private var viewModel: VerificationCodeViewModel
    
    @FocusState private var focusedField: Int?
    @State private var codeDigits: [String] = Array(repeating: "", count: 4)
    
    init(viewModel: VerificationCodeViewModel, onNeedRegister: @escaping (String, String) -> Void = { _, _ in }) {
        self.onNeedRegister = onNeedRegister
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    // MARK: - Body
    
    var body: some View {
        BaseView(title: "verification_code_title".localized) {
            VStack(spacing: 16) {
                
                Text("verification_code_description".localized)
                    .font(AppFont.regular(size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black.opacity(0.7))
                
                Text(viewModel.countryCode + viewModel.phone)
                    .font(AppFont.semiBold(size: 16))
                
                codeInputFields
                    .environment(\.layoutDirection, .leftToRight)
                    .padding(.top, 16)
                
                MainAppButton(
                    title: "verify_title".localized
                ) {
                    viewModel.code = codeDigits.joined()
                    viewModel.handleConfirm()
                }
                .padding(.top, 24)
                
                if !viewModel.canResendCode {
                    Text("verification_remaining_time_title".localized + " \(viewModel.formattedRemainingTime) " + "verification_seconds_suffix".localized)
                        .font(AppFont.regular(size: 14))
                        .foregroundColor(.black.opacity(0.6))
                        .padding(.top, 8)
                } else {
                    Button(action: {
                        viewModel.handleResend()
                    }) {
                        Text("resend_code_title".localized)
                            .font(AppFont.semiBold(size: 14))
                            .underline()
                            .foregroundColor(.green)
                    }
                    .padding(.top, 8)
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .onAppear {
            focusedField = 0
            viewModel.startTimer()
        }
        .alert(for: viewModel)
        .loader(for: viewModel)
        
        // MARK: - Bind networking outputs
        .onAppear{
            switch viewModel.type {
            case .loginAsUser:
                break
            case .sendSmsToCurrentPhone:
                viewModel.sendSmsToCurrentPhone()
            case .verifyNewPhone:
                break
            }
        }
        .onReceive(viewModel.isVerifyAndSignupAsUser) { response in
            UserDefaults.accessToken = response.data?.token
            UserDefaults.user = response.data
        }
        .onReceive(viewModel.isVerifyUserLogin) { response in
            UserDefaults.accessToken = response.data?.token
            UserDefaults.user = response.data
        }
        .onReceive(viewModel.$registerMessage) {  response in
            guard let response = response else { return }
            
            switch response.key {
            case .needComplete:
                authCoordinator.push(.completeRegisterData(phone: viewModel.phone, countryCode: viewModel.countryCode))
            case .success:
                print(UserDefaults.accessToken ?? "")
                    authCoordinator.loginSucceeded()
                
            default:
                break
            }
        }
        .onReceive(viewModel.isVerifyCurrentPhone) { _ in
            moreCoordinator.push(.changePhoneNumber)
        }
        .onReceive(viewModel.isVerifyNewPhone) { _ in
            moreCoordinator.popToRoot()
        }
        .onReceive(viewModel.isResendCode) { _ in
            viewModel.startTimer()
            
        }
        .onReceive(viewModel.isSendSmsToCurrentPhone) { _ in
            viewModel.startTimer()
        }
    }
}

// MARK: - Subviews

private extension VerificationCodeView {
    
    var isCodeComplete: Bool {
        codeDigits.joined().count == 4
    }
    
    var codeInputFields: some View {
        HStack(spacing: 10) {
            ForEach(0..<4, id: \.self) { index in
                VerificationCodeDigitView(
                    text: $codeDigits[index],
                    isFocused: focusedField == index
                )
                .focused($focusedField, equals: index)
                .onChange(of: codeDigits[index]) { newValue in
                    let filtered = newValue.filter { $0.isNumber }
                    if filtered.count > 1 {
                        codeDigits[index] = String(filtered.prefix(1))
                    } else {
                        codeDigits[index] = filtered
                    }
                    
                    if !codeDigits[index].isEmpty {
                        if index < 3 {
                            focusedField = index + 1
                        } else {
                            focusedField = nil
                        }
                    } else {
                        if index > 0 {
                            focusedField = index - 1
                        } else {
                            focusedField = 0
                        }
                    }
                    
                    viewModel.code = codeDigits.joined()
                }
            }
        }
        .frame(height: 80)
    }
}

