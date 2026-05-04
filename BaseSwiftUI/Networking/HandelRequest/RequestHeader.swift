//
//  RequestHeader.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/12/2023.
//

import Foundation

enum RequestHeaderType {
    
    case authorized(token: String)
    case unauthorized
    case ifAuthourized(token: String?)
    
    var header: [String:String] {
        
        var commonHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "lang": AppLanguageManager.shared.apiLanguage,
            "x-api-key": AppConfig.apiKey
        ]
        
        switch self {
        case .authorized(let token):
            commonHeaders["Authorization"] = "Bearer \(token)"
            return commonHeaders
        case .unauthorized:
            return commonHeaders
        case .ifAuthourized(let token):
            if let token {
                commonHeaders["Authorization"] = "Bearer \(token)"
            }
            return commonHeaders
        }
        
    }
    
}
