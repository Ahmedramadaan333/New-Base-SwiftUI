//
//  AuthEndPoint.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import Foundation
import SwiftUI

struct AuthEndPoint {
    private init() {}
}

extension AuthEndPoint {
    static
    func login(authModel: UserRegisterModel) -> Endpoint<BaseResponse<User>> {
        return .init(
            method: .post,
            path: "user/auth/login-send-code",
            body: [
                
                "phone": authModel.phone,
                "country_code": authModel.countryCode?.trimmedPlus,
                "device_id": UserDefaults.pushNotificationToken,
                "device_type": "ios",
                "mac_address":  UIDevice.current.identifierForVendor?.uuidString ?? ""
                
            ]
        )
    }
    static
    func verifyAndSignupAsUser(model: UserRegisterModel) -> Endpoint<BaseResponse<User>>{
        
        return Endpoint(
            method: .post,
            path: "user/auth/register",
            body: [
                "name": model.name,
                "phone": model.phone,
                "country_code": model.countryCode?.trimmedPlus,
                "email": model.email,
                "is_terms": model.terms,
                "device_id": UserDefaults.pushNotificationToken,
                "device_type": "ios"
                
            ], uploads: model.uploadData
        )
    }
    
    static
    func verifyUserLogin(phone: String, code: String, countryCode: String) -> Endpoint<BaseResponse<User>>{
        
        return Endpoint(
            method: .post,
            path: "user/auth/check-code",
            body: [
                "phone": phone,
                "country_code": countryCode.trimmedPlus,
                "code": code,
                "device_id": UserDefaults.pushNotificationToken,
                "device_type": "ios"
            ]
        )
    }
    
    static
    func resendCode(phone: String, countryCode: String)-> Endpoint<BaseResponse<User>>{
        
        return Endpoint(
            method: .post,
            path: "resend-code",
            body: [
                "phone": phone,
                "country_code": countryCode.trimmedPlus,
            ]
        )
    }
    
    
    static
    func sendSmsToCurrentPhone()-> Endpoint<BaseResponse<User>> {
        return Endpoint(
            method: .post,
            path: "user/change-phone/send-sms-to-current-phone",
            body: [
                "phone": String(UserDefaults.user?.phone ?? ""),
                "country_code": UserDefaults.user?.countryCode,            ] ,
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }
    
    static
    func verifyCurrentPhone(code: String)-> Endpoint<BaseResponse<User>> {
        return Endpoint(
            method: .post,
            path: "user/change-phone/verify-current-phone",
            body: [
                "code": code,
                "phone": String(UserDefaults.user?.phone ?? ""),
                "country_code": UserDefaults.user?.countryCode,
            ] ,
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }
    
    
    static
    func sendSmsToNewPhone(phone: String, countryCode: String)-> Endpoint<BaseResponse<User>> {
        return Endpoint(
            method: .post,
            path: "user/change-phone/send-sms-to-new-phone",
            body: [
                "phone": phone,
                "country_code": countryCode,
            ] ,
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }
    
    
    static
    func verifyNewPhone(phone: String, countryCode: String, code: String)-> Endpoint<BaseResponse<User>> {
        return Endpoint(
            method: .post,
            path: "user/change-phone/verify-new-phone",
            body: [
                "phone": phone,
                "country_code": countryCode,

                "code": code
            ] ,
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }
    static
    func getCountries() -> Endpoint<BaseResponse<[CountriesDataModel]>> {
        return .init(
            method: .get,
            path: "countries",
        )
    }
}
extension String {
    var trimmedPlus: String {
        self.hasPrefix("+") ? String(self.dropFirst()) : self
    }
}
