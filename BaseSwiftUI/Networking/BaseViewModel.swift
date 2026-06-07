//
//  BaseViewModel.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import Foundation
import SwiftUI
import Combine

class BaseViewModel: NSObject, ObservableObject {
    var isLoadingSubject = CurrentValueSubject<Bool, Never>(false)
    var errorSubject = PassthroughSubject<Error, Never>()
    var successSubject = PassthroughSubject<String, Never>()
    var warningSubject = PassthroughSubject<String, Never>()
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - in Case Using Pagination -
    
    var isLoading: Bool {
        return isLoadingSubject.value
    }
    
    let responseHandler: ResponseHandler
    
    init(responseHandler: ResponseHandler = DefaultResponseHandler()) {
        self.responseHandler = responseHandler
    }
    
    // MARK: - Main Request with BaseResponse
    
    func request<ResponseData: Decodable>(
        _ endPoint: Endpoint<BaseResponse<ResponseData>>,
        progress: ((_ progress: Int) -> Void)? = nil
    ) async throws -> ResponseData? {
        
        let response = try await self.responseHandler.get(endPoint, progress: progress)
        
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
    
    func getFullResponse<ResponseData: Decodable>(
        _ endPoint: Endpoint<BaseResponse<ResponseData>>,
        progress: ((_ progress: Int) -> Void)? = nil
    ) async throws -> BaseResponse<ResponseData>? {
        
        let response = try await self.responseHandler.get(endPoint, progress: progress)
        
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
    
    // MARK: - Raw Request (بدون BaseResponse)
    
    func request<ResponseData: Decodable>(
        _ endPoint: Endpoint<ResponseData>,
        progress: ((_ progress: Int) -> Void)? = nil
    ) async throws -> Decodable? {
        let response = try await self.responseHandler.get(endPoint, progress: progress)
        return response
    }
    func request<ResponseData: Decodable>(_ endPoint: Endpoint<ResponseData>, progress: ((_ progress: Int)-> Void)? = nil) async throws -> ResponseData? {
        let response = try await self.responseHandler.get(endPoint, progress: progress)
        return response
    }
    deinit {
        print("\(NSStringFromClass(self.classForCoder).components(separatedBy: ".").last ?? "BaseViewModel") is deinit, No memory leak found")
    }
}

// MARK: - Unauthorized / Blocked Handling

extension BaseViewModel {
    
    private func handleUnauthOrBlocked(message: String) {
        UserDefaults.user = nil
        UserDefaults.isLogin = false
        UserDefaults.accessToken = nil
        NotificationCenter.default.post(name: .userUnauthorized, object: nil)
    }
}

// MARK: - Helpers

extension BaseViewModel {
    func setLoading(_ value: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoadingSubject.send(value)
        }
    }
    
    func startLoading() {
        setLoading(true)
    }
    
    func stopLoading() {
        setLoading(false)
    }
    
    func emitError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard  let self else {return}
            errorSubject.send(error)
        }
    }
    
    func emitSuccess(_ message: String) {
        successSubject.send(message)
    }
    
    func emitWarning(_ message: String) {
        warningSubject.send(message)
    }
}

// MARK: - Live Field Binding

extension BaseViewModel {

    /// Connects one `@Published var xField: FieldState` to its live-validation rule.
    ///
    /// Replaces the 6-line `sink` block that every field used to need.
    /// Call once per field inside `init`, after `super.init()`.
    ///
    /// ```swift
    /// bindField(
    ///     on: self,
    ///     $phone.map(\.value).eraseToAnyPublisher(),
    ///     errorPath: \.phone.error
    /// ) { [weak self] value in
    ///     self?.validateFieldsUseCase.liveValidate(phone: value)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - root:      The ViewModel instance (always pass `self`).
    ///   - publisher: A `String` publisher derived from the field's value — e.g. `$phone.map(\.value).eraseToAnyPublisher()`.
    ///   - errorPath: Key path to the field's `error` string — e.g. `\.phone.error`.
    ///   - rule:      Closure that calls the Domain use case. Return `nil` = valid, `String` = error message.
    func bindField<Root: BaseViewModel>(
        on root: Root,
        _ publisher: AnyPublisher<String, Never>,
        errorPath: ReferenceWritableKeyPath<Root, String>,
        rule: @escaping (String) -> String?
    ) {
        publisher
            .dropFirst()                        // ignore the empty initial value on init
            .receive(on: DispatchQueue.main)
            .sink { [weak root] value in
                guard let root else { return }
                // Presentation concern: stay silent while the field is still empty.
                // The domain rule is only invoked once the user has typed something.
                if value.isEmpty {
                    root[keyPath: errorPath] = ""
                    return
                }
                root[keyPath: errorPath] = rule(value) ?? ""
            }
            .store(in: &cancellables)
    }
}

// MARK: - Notification Name

extension Notification.Name {
    static let userUnauthorized = Notification.Name("userUnauthorized")
}

