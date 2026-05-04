//
//  User.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import Foundation

struct User: Codable {
    var accountStatus: AccountStatus?
    var countryCode, email, fullPhone: String?
    var id: Int?
    var image: String?
    var isNotify: Bool?
    var lang, name, phone: String?
    var ratesAvg, ratesCount: Double?
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case accountStatus = "account_status"
        case countryCode = "country_code"
        case email
        case fullPhone = "full_phone"
        case id, image
        case isNotify = "is_notify"
        case lang, name, phone
        case ratesAvg = "rates_avg"
        case ratesCount = "rates_count"
        case token
    }
}

// MARK: - AccountStatus
struct AccountStatus: Codable {
    var status: String?
    var tripID: Int?
    
    enum CodingKeys: String, CodingKey {
        case status
        case tripID = "trip_id"
    }
}

struct LoginResponseModel : Codable{
    var codeExpireAt: String?
    var countryCode, phone, resendAfterSeconds: Int?
    
    enum CodingKeys: String, CodingKey {
        case codeExpireAt = "code_expire_at"
        case countryCode = "country_code"
        case phone
        case resendAfterSeconds = "resend_after_seconds"
    }
}
