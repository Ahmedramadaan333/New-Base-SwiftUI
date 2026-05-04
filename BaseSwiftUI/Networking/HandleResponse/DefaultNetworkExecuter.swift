//
//  DefaultNetworkExecuter.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 25/12/2023.
//

import Foundation
import Alamofire

struct DefaultNetworkExecuter: NetworkExecuter {
    
    func execute(_ request: any Requestable, progress progressHandler: ((_ progress: Int)-> Void)? = nil) async throws -> Data {
        
        guard let uploads = request.uploads, !uploads.isEmpty else {
            return try await self.send(request)
        }
        return try await self.upload(request, progress: progressHandler)
    }
    
    private func send(_ request: any Requestable) async throws -> Data {
        let result = await AF.request(request).serializingData().result
        return try self.handle(result)
    }
    
    private func upload(_ request: any Requestable, progress progressHandler: ((_ progress: Int)-> Void)?) async throws -> Data {
        var urlRequest = try request.asURLRequest()
        urlRequest.httpBody = nil
        let result = await AF.upload(multipartFormData: { multipartFormData in
            if let parameters = request.body?.compactMapValues({$0}) {
                for (key, value) in parameters {
                    append(value: value, withName: key, to: multipartFormData)
                }
            }
            for item in request.uploads ?? [] {
                multipartFormData.append(item.data, withName: item.key, fileName: item.filenameWithExtension, mimeType: item.mimeType.rawValue)
            }
        }, with: urlRequest).uploadProgress(queue: .main) { progress in
            let value = Int(progress.fractionCompleted*100)
            progressHandler?(value)
            #if DEBUG
            print("the Progress is \(value) %")
            #endif
        }.serializingData().result
        return try self.handle(result)
    }
    
    private func handle(_ result: Result<Data,AFError>) throws -> Data {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    private func append(value: Any, withName name: String, to multipartFormData: MultipartFormData) {
        if let array = value as? [Any] {
            for (index, item) in array.enumerated() {
                if let dict = item as? [String: Any] {
                    //MARK: - Array of Dictionary -
                    for (key, nestedValue) in dict {
                        let fullKey = "\(name)[\(index)][\(key)]"
                        append(value: nestedValue, withName: fullKey, to: multipartFormData)
                    }
                } else {
                    //MARK: Normal Array -
                    let fullKey = "\(name)[]"
                    if let data = "\(item)".data(using: .utf8) {
                        multipartFormData.append(data, withName: fullKey)
                    }
                }
            }
        } else if let dict = value as? [String: Any] {
            //MARK: - Dictionary -
            for (key, nestedValue) in dict {
                let fullKey = "\(name)[\(key)]"
                append(value: nestedValue, withName: fullKey, to: multipartFormData)
            }
        } else {
            //MARK: -Normal Value -
            if let data = "\(value)".data(using: .utf8) {
                multipartFormData.append(data, withName: name)
            }
        }
    }
}

