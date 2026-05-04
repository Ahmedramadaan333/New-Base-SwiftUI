//
//  AboutViewModel.swift
//  CTF
//
//  Created by Ahmed Ramadan on 27/11/2025.
//

import Foundation

@MainActor
class AppInfoViewModel: BaseViewModel {
    
    @Published private(set) var content: String?
    
    private let kind: InfoScreenKind
    
    init(kind: InfoScreenKind) {
        self.kind = kind
        super.init()
    }
}

// MARK: - Networking -
extension AppInfoViewModel {
    
    func fetch() {
        Task { [weak self] in
            guard let self else { return }
            
            self.startLoading()
            defer { self.stopLoading() }
            
            let endPoint = kind.endpoint
            
            do {
                let data: String? = try await self.request(endPoint)
                guard let data else { return }
                content = data
            } catch {
                self.emitError(error)
            }
        }
    }
}
