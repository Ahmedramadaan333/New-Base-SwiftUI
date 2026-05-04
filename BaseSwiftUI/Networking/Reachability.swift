//
//  Reachability.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 26/12/2023.
//

import Foundation
import Alamofire

class Reachability {
    private let manger = NetworkReachabilityManager(host: "www.apple.com")
    private(set) var lastStatus: NetworkReachabilityManager.NetworkReachabilityStatus?
    private var currentStatus: NetworkReachabilityManager.NetworkReachabilityStatus? {
        willSet {
            self.lastStatus = currentStatus
        }
    }
    func listen(onQueue: DispatchQueue = .main, onUpdatePerforming listener: @escaping NetworkReachabilityManager.Listener) {
        manger?.startListening(onQueue: onQueue){ [weak self] status in
            self?.currentStatus = status
            listener(status)
        }
    }
}
