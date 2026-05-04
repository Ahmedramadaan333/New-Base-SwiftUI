//
//  BaseCoordinator.swift
//  CTF
//
//  Created by Ahmed Ramadan on 16/11/2025.
//



import SwiftUI

@MainActor
class BaseCoordinator<Route: Hashable>: ObservableObject {

    @Published var path: [Route] = []
    @Published var presentedRoute: Route?
    func push(_ route: Route) {
        path.append(route)
    }

    @discardableResult
    func pop() -> Route? {
        path.popLast()
    }

    func popToRoot() {
        path.removeAll()
    }
    
    func reset() {
        path.removeAll()
    }

    func replace(with route: Route) {
        path = [route]
    }
    func present(_ route: Route) {
        presentedRoute = route
    }

    func dismiss() {
        presentedRoute = nil
    }
}


 
