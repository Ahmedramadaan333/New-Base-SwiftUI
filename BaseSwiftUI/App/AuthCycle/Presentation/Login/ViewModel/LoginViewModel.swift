//
//  LoginViewModel.swift
//  BaseSwiftUI
//

import Foundation

class LoginViewModel: BaseViewModel {

    @Published var showLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var phone: String = ""
    @Published var phoneError: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var confirmpassword: String = ""
    @Published var nameError: String = ""
    @Published var passwordError: String = ""
    @Published var confirmpasswordError: String = ""
    @Published private(set) var countries = [CountriesDataModel]()
    @Published var selectedCountry: CountriesDataModel? = nil
    @Published var isLoginSuccess = false
    @Published var loginModel: UserRegisterModel? = nil

    var phoneHasError: Bool { !phoneError.isEmpty }
    var nameHasError: Bool { !nameError.isEmpty }
    var passwordHasError: Bool { !passwordError.isEmpty }
    var confirmpasswordHasError: Bool { !confirmpasswordError.isEmpty }
    // MARK: - Dependencies

    private let loginUseCase: LoginUseCase
    private let getCountriesUseCase: GetCountriesUseCase

    // MARK: - Init

    init(loginUseCase: LoginUseCase, getCountriesUseCase: GetCountriesUseCase) {
        self.loginUseCase = loginUseCase
        self.getCountriesUseCase = getCountriesUseCase
        super.init()
        bindBaseViewModel()
    }

    private func bindBaseViewModel() {
        isLoadingSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                showLoading = isLoading
            }
            .store(in: &cancellables)

        $phone
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                liveValidatePhone(value)
            }
            .store(in: &cancellables)

        $name
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                liveValidateName(value)
            }
            .store(in: &cancellables)
        
        $password
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value  in
                guard let self = self else {return}
                liveValidatePassword(value)
            }.store(in: &cancellables)
       
        $confirmpassword
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value  in
                guard let self = self else {return}
                liveValidateConfirmPassword(password, value)
            }.store(in: &cancellables)
        
        $successMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                guard let self, let message else { return }
                emitSuccess(message)
            }
            .store(in: &cancellables)
        errorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self else { return }
                errorMessage = error.localizedDescription
                showError = true
            }
            .store(in: &cancellables)
    }
}

// MARK: - Live Validation (UX feedback while typing)

private extension LoginViewModel {

    func liveValidatePhone(_ value: String) {
        phoneError = ""
        do {
            _ = try AuthValidationService.validate(phone: value)
        } catch let error as AuthValidationError {
            if case .emptyPhone = error { return }
            phoneError = error.localizedDescription
        } catch {
            emitError(error)
        }
    }

    func liveValidateName(_ value: String) {
        nameError = ""
        do {
            _ = try AuthValidationService.validate(name: value)
        } catch let error as AuthValidationError {
            if case .emptyName = error { return }
            nameError = error.localizedDescription
        } catch {
            emitError(error)
        }
    }
    
    func liveValidatePassword(_ value: String) {
        passwordError = ""
        do{
            _ = try AuthValidationService.validate(password: value)
        }catch let error as AuthValidationError {
            if case .emptyPassword = error {
                return
            }
            passwordError = error.localizedDescription
        }catch{
            emitError(error)
        }
    }
    
    
    func liveValidateConfirmPassword(_ value: String, _ confirmValue: String) {
        confirmpasswordError = ""
        do{
            _ = try AuthValidationService.validate(password: value, confirmPassword: confirmValue)
        }catch let error as AuthValidationError {
            if case .emptyConfirmPassword = error {
                return
            }
            confirmpasswordError = error.localizedDescription
        }catch{
            emitError(error)
        }
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
                let model = UserRegisterModel(
                    name: name,
                    phone: phone,
                    countryCode: selectedCountry?.countryCode
                )
                let data = try await loginUseCase.execute(model: model)
                successMessage = data.message
                loginModel = model
                isLoginSuccess = true
            } catch let error as AuthValidationError {
                handleValidationError(error)
            } catch {
                emitError(error)
            }
        }
    }

    private func handleValidationError(_ error: AuthValidationError) {
        switch error {
        case .emptyPhone, .shortPhone, .longPhone:
            phoneError = error.localizedDescription
        case .emptyName, .shortName, .longName:
            nameError = error.localizedDescription
        default:
            emitError(error)
        }
    }

    func getCountries() {
        let country = CountriesDataModel(id: 1, name: "Egypt", key: "+20", flag: "🇪🇬")
        countries.append(country)
        // Uncomment to fetch from API via use case:
        // Task { [weak self] in
        //     guard let self else { return }
        //     self.startLoading()
        //     defer { self.stopLoading() }
        //     do {
        //         let data = try await getCountriesUseCase.execute()
        //         self.countries = data ?? []
        //         if self.selectedCountry == nil { self.selectedCountry = data?.first }
        //     } catch { self.emitError(error) }
        // }
    }
}
