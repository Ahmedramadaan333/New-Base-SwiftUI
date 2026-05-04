//
//  ShowProfileViewModel.swift
//  CTF
//
//  Created by Ahmed Ramadan on 07/12/2025.
//

import Foundation

class ShowProfileViewModel: BaseViewModel{
    @Published private(set) var user: User?
}

//MARK: - Networking -

extension ShowProfileViewModel{
    func showProfile() {
        Task { [weak self] in
            guard let self else { return }
            
            self.startLoading()
            defer { self.stopLoading() }
            
            let endPoint = MoreEndPoint.showProfile()
            do {
                let data = try await self.request(endPoint)
                guard let data = data else { return }
                await MainActor.run {
                    self.user =  data
                }
            } catch {
                self.emitError(error)
            }
        }
    }
}

