//
//  HomeEndPoints.swift
//  BaseSwiftUI
//
//  TODO: Replace the stub path with your actual home API route.
//

import Foundation

struct HomeEndPoints {
    private init() {}
}

extension HomeEndPoints {

    static func getHomeData() -> Endpoint<BaseResponse<HomeData>> {
        .init(
            method: .get,
            path: "home",                       // TODO: update path
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }
}
