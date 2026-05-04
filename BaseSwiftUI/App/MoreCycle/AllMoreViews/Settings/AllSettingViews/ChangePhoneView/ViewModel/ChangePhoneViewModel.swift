//
//  ChangePhoneViewModel.swift
//  CTF
//
//  Created by Ahmed Ramadan on 06/12/2025.
//

import Foundation
import Combine

class ChangePhoneViewModel : BaseViewModel{
    @Published var phoneError: String = ""
    @Published var phone: String = ""
    @Published private(set) var countries =  [CountriesDataModel]()
    @Published var selectedCountry: CountriesDataModel? = nil
    @Published var forceValidatePhone = false
    @Published var isSendSmsToNewPhone : User?

    var phoneHasError: Bool {
        !phoneError.isEmpty
    }
    override init(responseHandler: ResponseHandler = DefaultResponseHandler()) {
        super.init(responseHandler: responseHandler)
        bindViewModel()
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
    private func bindViewModel() {
        $phone
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else {return}
                liveValidatePhone(value)
            }
            .store(in: &cancellables)
    }
}

//MARK: - Networking -
@MainActor
extension ChangePhoneViewModel{
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
    func sendSmsToNewPhone(phone: String, countryCode: String) {
        Task {
            self.startLoading()
            defer { self.stopLoading() }
            let endPoint = AuthEndPoint.sendSmsToNewPhone(phone: phone, countryCode: countryCode)
            do {
                let response = try await self.getFullResponse(endPoint)
                guard let response else {return}
                isSendSmsToNewPhone = response.data
            } catch {
                emitError(error)
            }
        }
    }
}


extension ChangePhoneViewModel {
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
            sendSmsToNewPhone(phone: model.phone ?? "" , countryCode: model.countryCode ?? "")
            
        } catch let error as AuthValidationError {
            handleValidationError(error)
        } catch {
            emitError(error)
        }
    }
}

