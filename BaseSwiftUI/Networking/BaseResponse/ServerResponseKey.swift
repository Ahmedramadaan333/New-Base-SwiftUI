//
//  ServerResponseKey.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/12/2023.
//

import Foundation

enum ServerResponseKey: String, Decodable {
    case success
    case fail
    case unauthenticated = "unauthenticated"
    case needActive = "needActive"
    case rejeted = "approved_rejected"
    case exception
    case blocked
    case needComplete = "need_to_complete_data"
}
