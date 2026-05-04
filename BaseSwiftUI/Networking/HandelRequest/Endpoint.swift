//
//  Endpoint.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/12/2023.
//

import Foundation

struct Endpoint<T: Decodable>: Requestable{
    
    typealias Response = T
    
    let server: String
    
    let method: RequestMethod
    
    let path: String
    
    let queries: APIParameters?
    
    let body: APIParameters?
    
    let headerType: RequestHeaderType
    
    let uploads: [UploadData]?
    
    let decoder: ResponseDecoder
    
    
    init(
        server: String = NetworkConstants.server,
        method: RequestMethod = .get,
        path: String,
        queries: APIParameters? = nil,
        body: APIParameters? = nil,
        headerType: RequestHeaderType = .unauthorized,
        uploads: [UploadData]? = nil,
        decoder: ResponseDecoder = DefaultJSONDecoder()
    ) {
        self.server = server
        self.method = method
        self.path = path
        self.queries = queries
        self.body = body
        self.headerType = headerType
        self.uploads = uploads
        self.decoder = decoder
    }
    
}

