//
//  ResponseHandler.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/12/2023.
//

import Foundation

protocol ResponseHandler {
    func get<T: Decodable>(_ endpoint: Endpoint<T>, progress: ((_ progress: Int)-> Void)?) async throws -> T
}

struct DefaultResponseHandler: ResponseHandler {
    
    private let networkExecuter: NetworkExecuter
    
    init(networkExecuter: NetworkExecuter = DefaultNetworkExecuter()) {
        self.networkExecuter = networkExecuter
    }
    
    func get<T: Decodable>(_ endpoint: Endpoint<T>, progress: ((_ progress: Int)-> Void)? = nil) async throws -> T {
        let data = try await self.networkExecuter.execute(endpoint, progress: progress)
        self.printApiResponse(data, for: endpoint.server+endpoint.path)
        return try  endpoint.decoder.decode(data: data)
    }
    
    private func printApiResponse(_ responseData: Data?, for url: String) {
    #if DEBUG
        guard let responseData = responseData else {
            print("\n\n====================================\n⚡️⚡️RESPONSE FOR \(url) IS::\n" ,responseData as Any, "\n====================================\n\n")
            return
        }
        
        if let object = try? JSONSerialization.jsonObject(with: responseData, options: []),
           let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys]), let JSONString = String(data: data, encoding: String.Encoding.utf8) {
            print("\n\n====================================\n⚡️⚡️RESPONSE FOR \(url) IS::\n" ,JSONString, "\n====================================\n\n")
            return
        }
        print("\n\n====================================\n⚡️⚡️RESPONSE FOR \(url) IS::\n" ,responseData, "\n====================================\n\n")
    #endif
    }
}
