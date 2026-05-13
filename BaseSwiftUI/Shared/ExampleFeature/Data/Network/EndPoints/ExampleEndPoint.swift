//
//  ExampleEndPoint.swift
//  BaseSwiftUI
//
//  Template: API endpoint definitions for this feature.
//  Replace "example" path with your actual API route.
//

import Foundation

struct ExampleEndPoint {
    private init() {}
}

extension ExampleEndPoint {

    // TODO: Replace path and headerType with your actual values.
    static func getList() -> Endpoint<BaseResponse<[ExampleModel]>> {
        .init(
            method: .get,
            path: "example/list",           // TODO: update path
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }
}
