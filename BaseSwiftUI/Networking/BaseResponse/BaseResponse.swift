//
//  BaseResponse.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/12/2023.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    var key: ServerResponseKey
    var message: String
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case key
        case message = "msg"
        case data
    }
    
}
