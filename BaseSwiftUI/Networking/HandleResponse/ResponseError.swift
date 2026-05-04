//
//  ResponseError.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/12/2023.
//

import Foundation

enum ResponseError: Error {
    case canNotConnectToServer
    case serverError
    case unableToDecodeResponse
    case server(message: String)
}

extension ResponseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .canNotConnectToServer:
            return "Can not send request, please check your connection"
        case .serverError:
            return "There is an error in our servers and we work on it, please try again later"
        case .unableToDecodeResponse:
            return "unexpected error happened and we will work on it, please try again later"
        case .server(let message):
            return message
        }
    }
}

