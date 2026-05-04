//
//  MoreEndPoint.swift
//  BaseSwiftUI
//
//  Generic user/settings endpoints reusable across projects.
//  TODO: Update paths to match your backend's API routes.
//

import Foundation

struct MoreEndPoint {
    private init() {}
}

extension MoreEndPoint {

    static func signOut() -> Endpoint<BaseResponse<String>> {
        return .init(
            method: .post,
            path: "user/auth/sign-out",
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }

    static func showProfile() -> Endpoint<BaseResponse<User>> {
        return .init(
            method: .get,
            path: "user/profile",
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }

    static func EditProfile(model: UserRegisterModel) -> Endpoint<BaseResponse<User>> {
        return Endpoint(
            method: .post,
            path: "user/profile/update",
            body: [
                "name": model.name,
                "email": model.email
            ],
            headerType: .authorized(token: UserDefaults.accessToken ?? ""),
            uploads: model.uploadData
        )
    }

    static func changeNotificationsStatus() -> Endpoint<BaseResponse<User>> {
        return .init(
            method: .post,
            path: "user/notifications/toggle",
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }

    static func deleteAccount() -> Endpoint<BaseResponse<String>> {
        return .init(
            method: .delete,
            path: "user/account",
            headerType: .authorized(token: UserDefaults.accessToken ?? "")
        )
    }

    static func getAboutApp() -> Endpoint<BaseResponse<String>> {
        return .init(
            method: .get,
            path: "settings/about-app"
        )
    }

    static func getTerms() -> Endpoint<BaseResponse<String>> {
        return .init(
            method: .get,
            path: "settings/terms"
        )
    }

    static func getPrivacy() -> Endpoint<BaseResponse<String>> {
        return .init(
            method: .get,
            path: "settings/privacy"
        )
    }
}
