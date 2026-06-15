//
//  LoginModel.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import Foundation

struct UserRegisterModel: Codable {
    var imageData: Data?
    var name: String?
    var phone: String?
    var countryCode: String?
    var code: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    var acceptTerms: Bool? =  false
    var uploadData: [UploadData] {
        guard let data = imageData else { return [] }
        return [.init(key: "image", data: data, mimeType: .jpeg, fileName: "\(Date().timeIntervalSince1970).jpeg")]
    }
    var terms:Int? {
        switch acceptTerms {
            case true:
            return 1
        default:
            return 0
        }
    }
}
