//
//  AuthVerificationCodeViewModel.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//


import Foundation
import Combine

final class VerificationCodeViewModel: BaseViewModel {
    
    // MARK: - Inputs
    
    let phone: String
    let countryCode: String
    let type: AuthVerificationType
    
    @Published var code: String = ""
    
    // MARK: - Timer
    
    @Published var remainingSeconds: Int = 60
    @Published var canResendCode: Bool = false
    
    private var timer: Timer?
    
    // MARK: - Networking properties -
    
    @Published var registerModel = UserRegisterModel()
    
    var isVerifyAndSignupAsUser = PassthroughSubject<BaseResponse<User>, Never>()
    var isVerifyUserLogin = PassthroughSubject<BaseResponse<User>, Never>()
    
    var isResendCode = PassthroughSubject<BaseResponse<User>, Never>()
    var isSendSmsToCurrentPhone = PassthroughSubject<BaseResponse<User>, Never>()
    
    var isVerifyCurrentPhone = PassthroughSubject<BaseResponse<User>, Never>()
    var isSendSmsToNewPhone = PassthroughSubject<BaseResponse<User>, Never>()
    var isVerifyNewPhone = PassthroughSubject<BaseResponse<User>, Never>()
    
    @Published var registerMessage: BaseResponse<User>?
    
    // MARK: - Init / Deinit
    
    init(phone: String, countryCode: String, type: AuthVerificationType) {
        self.phone = phone
        self.countryCode = countryCode
        self.type = type
        super.init()
    }
    
    deinit {
        invalidateTimer()
    }
    
    // MARK: - Timer helpers
    
    var formattedRemainingTime: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        invalidateTimer()
        remainingSeconds = 60
        canResendCode = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self else { return }
            
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                self.canResendCode = true
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Actions from View
    
    func handleConfirm() {
        switch type {
        case .loginAsUser:
            validation(code: code)
            
        case .sendSmsToCurrentPhone:
            validationCurrentPhone(code: code)
            
        case .verifyNewPhone:
            validationNewPhone(code: code)
        }
    }
    
    func handleResend() {
        switch type {
        case .loginAsUser,
                .verifyNewPhone:
            resendCode(phone: phone, countryCode: countryCode)
            
        case .sendSmsToCurrentPhone:
            let currentPhone = "\(UserDefaults.user?.phone ?? "")"
            let currentCountry = "\(UserDefaults.user?.countryCode ?? "")"
            resendCode(phone: currentPhone, countryCode: currentCountry)
        }
    }
}

// MARK: - Validation -

extension VerificationCodeViewModel {
    
    func validation(code: String) {
        do {
            registerModel.code = try AuthValidationService.validate(verificationCode: code)
            
            verifyUserLogin(phone: phone, code: code, countryCode: countryCode)
            
        } catch {
            emitError(error)
        }
    }
    
    func validationCurrentPhone(code: String) {
        do {
            let validatedCode = try AuthValidationService.validate(verificationCode: code)
            verifyCurrentPhone(code: validatedCode)
        } catch {
            emitError(error)
        }
    }
    
    func validationNewPhone(code: String) {
        do {
            let validatedCode = try AuthValidationService.validate(verificationCode: code)
            verifyNewPhone(phone: phone, code: validatedCode, countryCode: countryCode)
        } catch {
            emitError(error)
        }
    }
}

// MARK: - Networking -

extension VerificationCodeViewModel {
    
    
    private func verifyUserLogin(phone: String, code: String, countryCode: String) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            let endPoint = AuthEndPoint.verifyUserLogin(phone: phone, code: code, countryCode: countryCode)
            do {
                let response = try await self.getFullResponse(endPoint)
                guard let response = response else { return }
                await MainActor.run {
                    self.registerMessage = response
                    if registerMessage?.key == .success {
                        guard let data = response.data else { return }
                        UserDefaults.accessToken = data.token
                        UserDefaults.user = data
                        
                    }
                }
            } catch {
                emitError(error)
            }
        }
    }
    
    func resendCode(phone: String, countryCode: String) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            let endPoint = AuthEndPoint.login(authModel: .init(imageData: nil , name: nil, phone: phone ,countryCode: countryCode))
            do {
                let response = try await self.getFullResponse(endPoint)
                guard let response else {return}
                isResendCode.send(response)
                emitSuccess(response.message)
            } catch {
                emitError(error)
            }
        }
    }
    
    func sendSmsToCurrentPhone() {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            let endPoint = AuthEndPoint.sendSmsToCurrentPhone()
            do {
                let response = try await self.getFullResponse(endPoint)
                guard let response else {return}
                await MainActor.run {
                    
                    isSendSmsToCurrentPhone.send(response)
                }
            } catch {
                emitError(error)
            }
        }
    }
    
    func verifyCurrentPhone(code: String) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            let endPoint = AuthEndPoint.verifyCurrentPhone(code: code)
            do {
                let response = try await self.getFullResponse(endPoint)
                guard let response else {return}
                await MainActor.run {
                    
                    isVerifyCurrentPhone.send(response)
                }
            } catch {
                emitError(error)
            }
        }
    }
    
    func sendSmsToNewPhone(phone: String, countryCode: String) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            let endPoint = AuthEndPoint.sendSmsToNewPhone(phone: phone, countryCode: countryCode)
            do {
                let response = try await self.getFullResponse(endPoint)
                guard let response else {return}
                isSendSmsToNewPhone.send(response)
            } catch {
                emitError(error)
            }
        }
    }
    
    func verifyNewPhone(phone: String, code: String , countryCode: String) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            let endPoint = AuthEndPoint.verifyNewPhone(phone: phone, countryCode: countryCode, code: code)
            do {
                let response = try await self.getFullResponse(endPoint)
                guard let response else {return}
                await MainActor.run {
                    emitSuccess(response.message)
                    isVerifyNewPhone.send(response)
                    UserDefaults.user?.phone = response.data?.phone
                    UserDefaults.user?.countryCode = response.data?.countryCode
                }
            } catch {
                emitError(error)
            }
        }
    }
}
