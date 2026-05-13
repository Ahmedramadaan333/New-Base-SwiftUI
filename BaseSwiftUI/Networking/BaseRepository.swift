//
//  BaseRepository.swift
//  BaseSwiftUI
//
//  Shared base class for all cycle repositories.
//  Mirrors the request / getFullResponse logic from BaseViewModel
//  so repositories don't duplicate network-response handling.
//

import Foundation

class BaseRepository {

    let responseHandler: ResponseHandler

    init(responseHandler: ResponseHandler = DefaultResponseHandler()) {
        self.responseHandler = responseHandler
    }

    // MARK: - Main Request with BaseResponse

    func request<T: Decodable>(
        _ endpoint: Endpoint<BaseResponse<T>>,
        progress: ((_ progress: Int) -> Void)? = nil
    ) async throws -> T? {

        let response = try await responseHandler.get(endpoint, progress: progress)

        switch response.key {
        case .success:
            return response.data

        case .fail:
            throw ResponseError.server(message: response.message)

        case .unauthenticated, .blocked:
            handleUnauthOrBlocked(message: response.message)
            throw ResponseError.server(message: response.message)

        case .needActive:
            return response.data

        case .exception:
            throw ResponseError.serverError

        case .needComplete:
            return response.data

        case .rejeted:
            return response.data
        }
    }

    func getFullResponse<T: Decodable>(
        _ endpoint: Endpoint<BaseResponse<T>>,
        progress: ((_ progress: Int) -> Void)? = nil
    ) async throws -> BaseResponse<T> {

        let response = try await responseHandler.get(endpoint, progress: progress)

        switch response.key {
        case .success:
            return response

        case .fail:
            throw ResponseError.server(message: response.message)

        case .unauthenticated, .blocked:
            handleUnauthOrBlocked(message: response.message)
            throw ResponseError.server(message: response.message)

        case .needActive:
            return response

        case .exception:
            throw ResponseError.serverError

        case .needComplete:
            return response

        case .rejeted:
            return response
        }
    }

    // MARK: - Unauthorized / Blocked Handling

    private func handleUnauthOrBlocked(message: String) {
        UserDefaults.user = nil
        UserDefaults.isLogin = false
        UserDefaults.accessToken = nil
        NotificationCenter.default.post(name: .userUnauthorized, object: nil)
    }
}
