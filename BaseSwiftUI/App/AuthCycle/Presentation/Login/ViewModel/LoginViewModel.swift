//
//  LoginViewModel.swift
//  BaseSwiftUI
//

import Foundation
import Combine

class LoginViewModel: BaseViewModel {

    // MARK: - Form Fields
    // One @Published var per field — value, error, and hasError are all inside FieldState.

    @Published var phone           = FieldState()
    @Published var name            = FieldState()
    @Published var password        = FieldState()
    @Published var confirmPassword = FieldState()

    // MARK: - Other State

    @Published var showLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published private(set) var countries: [CountriesDataModel] = []
    @Published var selectedCountry: CountriesDataModel? = nil
    @Published var isLoginSuccess = false
    @Published var loginModel: UserRegisterModel? = nil

    // MARK: - Dependencies

    private let loginUseCase: LoginUseCase
    private let getCountriesUseCase: GetCountriesUseCase
    private let validateFieldsUseCase: ValidateLoginFieldsUseCase

    // MARK: - Init

    init(
        loginUseCase: LoginUseCase,
        getCountriesUseCase: GetCountriesUseCase,
        validateFieldsUseCase: ValidateLoginFieldsUseCase
    ) {
        self.loginUseCase = loginUseCase
        self.getCountriesUseCase = getCountriesUseCase
        self.validateFieldsUseCase = validateFieldsUseCase
        super.init()
        bindLiveValidations()
        bindBaseViewModel()
    }

    // MARK: - Live Validation
    // One bindField call per field replaces:
    //   • the 6-line sink block
    //   • the liveValidateX() function
    // Validation rules live in ValidateLoginFieldsUseCase (Domain layer).

    private func bindLiveValidations() {
        bindField(on: self, $phone.map(\.value).eraseToAnyPublisher(), errorPath: \.phone.error) {
            [weak self] value in self?.validateFieldsUseCase.liveValidate(phone: value)
        }

        bindField(on: self, $name.map(\.value).eraseToAnyPublisher(), errorPath: \.name.error) {
            [weak self] value in self?.validateFieldsUseCase.liveValidate(name: value)
        }

        bindField(on: self, $password.map(\.value).eraseToAnyPublisher(), errorPath: \.password.error) {
            [weak self] value in self?.validateFieldsUseCase.liveValidate(password: value)
        }

        // confirmPassword re-validates whenever either confirmPassword OR password changes.
        Publishers.CombineLatest($confirmPassword.map(\.value), $password.map(\.value))
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] confirm, pass in
                guard let self else { return }
                guard !confirm.isEmpty else { confirmPassword.error = ""; return }
                confirmPassword.error = validateFieldsUseCase.liveValidate(
                    confirmPassword: confirm,
                    against: pass
                ) ?? ""
            }
            .store(in: &cancellables)
    }

    // MARK: - Base ViewModel bindings

    private func bindBaseViewModel() {
        isLoadingSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.showLoading = $0 }
            .store(in: &cancellables)

        errorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self else { return }
                errorMessage = error.localizedDescription
                showError = true
            }
            .store(in: &cancellables)

        $successMessage
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] in self?.emitSuccess($0) }
            .store(in: &cancellables)
    }
}

// MARK: - Networking

@MainActor
extension LoginViewModel {

    func login() {
        Task {
            startLoading()
            defer { stopLoading() }
            do {
                // LoginUseCase.execute owns submit-time validation (throws AuthValidationError).
                let model = UserRegisterModel(
                    name: name.value,
                    phone: phone.value,
                    countryCode: selectedCountry?.countryCode
                )
                let data = try await loginUseCase.execute(model: model)
                successMessage = data.message
                loginModel = model
                isLoginSuccess = true
            } catch let error as AuthValidationError {
                // Map thrown validation errors back to the correct field.
                switch error {
                case .emptyPhone, .shortPhone, .longPhone:
                    phone.error = error.localizedDescription
                case .emptyName, .shortName, .longName:
                    name.error = error.localizedDescription
                default:
                    emitError(error)
                }
            } catch {
                emitError(error)
            }
        }
    }

    func getCountries() {
        let country = CountriesDataModel(id: 1, name: "Egypt", key: "+20", flag: "🇪🇬")
        countries.append(country)
    }
}
