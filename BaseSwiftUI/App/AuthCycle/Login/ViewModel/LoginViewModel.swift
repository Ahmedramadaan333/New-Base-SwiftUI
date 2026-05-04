//
//  LoginViewModel.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import Foundation

class LoginViewModel: BaseViewModel {
    @Published var showLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var phoneError: String = ""
    @Published var phone: String = ""
    @Published private(set) var countries =  [CountriesDataModel]()
    @Published var selectedCountry: CountriesDataModel? = nil
    @Published var forceValidatePhone = false
    
    @Published var isLoginSuccess = false
    @Published var loginModel: UserRegisterModel? = nil
    
    var phoneHasError: Bool {
        !phoneError.isEmpty
    }
    
    
    override init(responseHandler: ResponseHandler = DefaultResponseHandler()) {
        super.init(responseHandler: responseHandler)
        bindBaseViewModel()
    }
    func liveValidatePhone(_ value: String) {
        phoneError = ""
        do {
            _ = try AuthValidationService.validate(phone: value)
        }
        catch let error as AuthValidationError {
            if case .emptyPhone = error { return }
            phoneError = error.localizedDescription
            
        }catch{
            emitError(error)
            
        }
    }    
    
    private func bindBaseViewModel() {
        isLoadingSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else {return}
                showLoading = isLoading
            }
            .store(in: &cancellables)
        $phone
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else {return}
                liveValidatePhone(value)
            }
            .store(in: &cancellables)
        $successMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                guard  let self, let message else {return}
                emitSuccess(message)
            }
            .store(in: &cancellables)
        errorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self else {return}
                errorMessage = error.localizedDescription
                showError = true
            }
            .store(in: &cancellables)
    }
    
    
}

//MARK: - Validation -

extension LoginViewModel {
    private func handleValidationError(_ error: AuthValidationError) {
        switch error {
        case .emptyPhone, .shortPhone, .longPhone:
            phoneError = error.localizedDescription
        default:
            emitError(error)
        }
    }
    
    @MainActor
    func validateLogin(model: UserRegisterModel)  {
        phoneError = ""
        do {
            _ = try AuthValidationService.validate(phone: model.phone)
            
            login(model: model)
        } catch let error as AuthValidationError {
            handleValidationError(error)
        } catch {
            emitError(error)
        }
    }
}

//MARK: - Networking -
@MainActor
extension LoginViewModel{
    private func login(model: UserRegisterModel) {
        
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            let endPoint = AuthEndPoint.login(authModel: model)
            do {
                let data = try await self.getFullResponse(endPoint)
                guard let data = data else {return}
                successMessage = data.message
                self.loginModel = model
                self.isLoginSuccess = true
            } catch {
                emitError(error)
            }
        }
    }
    
    func getCountries() {
        Task { [weak self] in
            guard let self else { return }
            
            self.startLoading()
            defer { self.stopLoading() }
            
            let endPoint = AuthEndPoint.getCountries()
            do {
                let data = try await self.request(endPoint)
                guard let data = data else { return }
                
                self.countries = data
                if self.selectedCountry == nil {
                    self.selectedCountry = data.first
                }
            } catch {
                self.emitError(error)
            }
        }
    }
}
