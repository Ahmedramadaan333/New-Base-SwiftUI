//
//  VerificationCodeViewModel.swift
//  BaseSwiftUI
//

import Foundation
import Combine

final class VerificationCodeViewModel: BaseViewModel {

    // MARK: - Inputs

    let phone: String
    let countryCode: String
    let type: AuthVerificationType

    // No live validation on code — it is assembled digit-by-digit in the View
    // and set in full just before handleConfirm() is called.
    @Published var code: String = ""

    // MARK: - Timer

    @Published var remainingSeconds: Int = 60
    @Published var canResendCode: Bool = false

    private var timer: Timer?

    // MARK: - Networking properties

    @Published var registerModel = UserRegisterModel()

    var isVerifyAndSignupAsUser = PassthroughSubject<BaseResponse<User>, Never>()
    var isVerifyUserLogin       = PassthroughSubject<BaseResponse<User>, Never>()
    var isResendCode            = PassthroughSubject<BaseResponse<User>, Never>()
    var isSendSmsToCurrentPhone = PassthroughSubject<BaseResponse<User>, Never>()
    var isVerifyCurrentPhone    = PassthroughSubject<BaseResponse<User>, Never>()
    var isSendSmsToNewPhone     = PassthroughSubject<BaseResponse<User>, Never>()
    var isVerifyNewPhone        = PassthroughSubject<BaseResponse<User>, Never>()

    @Published var registerMessage: BaseResponse<User>?

    // MARK: - Dependencies

    private let verifyCodeUseCase: VerifyCodeUseCase
    private let resendCodeUseCase: ResendCodeUseCase
    private let changePhoneUseCase: ChangePhoneUseCase
    private let validateFieldsUseCase: ValidateVerificationFieldsUseCase

    // MARK: - Init / Deinit

    init(
        phone: String,
        countryCode: String,
        type: AuthVerificationType,
        verifyCodeUseCase: VerifyCodeUseCase,
        resendCodeUseCase: ResendCodeUseCase,
        changePhoneUseCase: ChangePhoneUseCase,
        validateFieldsUseCase: ValidateVerificationFieldsUseCase
    ) {
        self.phone = phone
        self.countryCode = countryCode
        self.type = type
        self.verifyCodeUseCase = verifyCodeUseCase
        self.resendCodeUseCase = resendCodeUseCase
        self.changePhoneUseCase = changePhoneUseCase
        self.validateFieldsUseCase = validateFieldsUseCase
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
            validateAndRun(code: code) { [weak self] validCode in
                guard let self else { return }
                verifyUserLogin(phone: phone, code: validCode, countryCode: countryCode)
            }
        case .sendSmsToCurrentPhone:
            validateAndRun(code: code) { [weak self] validCode in
                self?.verifyCurrentPhone(code: validCode)
            }
        case .verifyNewPhone:
            validateAndRun(code: code) { [weak self] validCode in
                guard let self else { return }
                verifyNewPhone(phone: phone, code: validCode, countryCode: countryCode)
            }
        }
    }

    func handleResend() {
        switch type {
        case .loginAsUser, .verifyNewPhone:
            resendCode(phone: phone, countryCode: countryCode)
        case .sendSmsToCurrentPhone:
            let currentPhone   = UserDefaults.user?.phone ?? ""
            let currentCountry = UserDefaults.user?.countryCode ?? ""
            resendCode(phone: currentPhone, countryCode: currentCountry)
        }
    }

    // MARK: - Private helpers

    /// Validates the code via the use case, then runs `action` with the validated value.
    private func validateAndRun(code: String, action: @escaping (String) -> Void) {
        do {
            let validCode = try validateFieldsUseCase.validate(code: code)
            registerModel.code = validCode
            action(validCode)
        } catch {
            emitError(error)
        }
    }
}

// MARK: - Networking

extension VerificationCodeViewModel {

    private func verifyUserLogin(phone: String, code: String, countryCode: String) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            do {
                let response = try await verifyCodeUseCase.executeLogin(phone: phone, code: code, countryCode: countryCode)
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
            do {
                let response = try await resendCodeUseCase.execute(phone: phone, countryCode: countryCode)
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
            do {
                let response = try await changePhoneUseCase.executeSendSmsToCurrentPhone()
                await MainActor.run { isSendSmsToCurrentPhone.send(response) }
            } catch {
                emitError(error)
            }
        }
    }

    func verifyCurrentPhone(code: String) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            do {
                let response = try await changePhoneUseCase.executeVerifyCurrentPhone(code: code)
                await MainActor.run { isVerifyCurrentPhone.send(response) }
            } catch {
                emitError(error)
            }
        }
    }

    func sendSmsToNewPhone(phone: String, countryCode: String) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            do {
                let response = try await changePhoneUseCase.executeSendSmsToNewPhone(phone: phone, countryCode: countryCode)
                isSendSmsToNewPhone.send(response)
            } catch {
                emitError(error)
            }
        }
    }

    func verifyNewPhone(phone: String, code: String, countryCode: String) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            do {
                let response = try await changePhoneUseCase.executeVerifyNewPhone(phone: phone, countryCode: countryCode, code: code)
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
