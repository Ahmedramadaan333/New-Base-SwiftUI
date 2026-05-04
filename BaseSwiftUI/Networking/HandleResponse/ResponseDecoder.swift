//
//  ResponseDecoder.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/12/2023.
//

import Foundation

protocol ResponseDecoder: Sendable {
    func decode<T: Decodable>(data: Data) throws -> T
}

struct DefaultJSONDecoder: ResponseDecoder {
    func decode<T: Decodable>(data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            let object  = try decoder.decode(T.self, from: data)
            
            return object
        } catch DecodingError.keyNotFound(let key, let context) {
            print("could not find key \(key) in JSON: \(context.debugDescription)")
            print(context.codingPath)
            throw ResponseError.unableToDecodeResponse
        } catch DecodingError.valueNotFound(let type, let context) {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
            print(context.codingPath)
            throw ResponseError.unableToDecodeResponse
        } catch DecodingError.typeMismatch(let type, let context) {
            print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            print(context.codingPath)
            throw ResponseError.unableToDecodeResponse
        } catch DecodingError.dataCorrupted(let context) {
            print("data found to be corrupted in JSON: \(context.debugDescription)")
            print(context.codingPath)
            throw ResponseError.unableToDecodeResponse
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            if error as? ResponseError != nil {
                throw error
            } else {
                throw ResponseError.unableToDecodeResponse
            }
        }
    }
}
