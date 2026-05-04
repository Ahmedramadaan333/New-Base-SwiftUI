//
//  MoreSectionsFactory.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 31/07/2025.
//
import SwiftUI


enum MoreSectionsFactory {
    
    static func userSections(
        navigate: @escaping (MoreRowID) -> Void,
        logout: @escaping () -> Void) -> [AnyMoreSection] {
        let mainItems: [MoreItemModel] = [
            MoreItemModel(
                id: .settings,
                title: "settings_title".localized,
                imageName: MoreSectionsImages.settings.rawValue,
                showChevron: true,
                titleColor: .black,
                action: { navigate(.settings) }
            ),
            MoreItemModel(
                id: .terms,
                title: "terms_and_conditions_title".localized,
                imageName: MoreSectionsImages.terms.rawValue,
                showChevron: true,
                titleColor: .black,
                action: { navigate(.terms) }
            ),
            MoreItemModel(
                id: .about,
                title:"about_app_title".localized,
                imageName: MoreSectionsImages.aboutApp.rawValue,
                showChevron: true,
                titleColor: .black,
                action: { navigate(.about) }
            ),
            MoreItemModel(
                id: .privacy,
                title:"privacy_title".localized,
                imageName: MoreSectionsImages.policy.rawValue,
                showChevron: true,
                titleColor: .black,
                action: { navigate(.privacy) }
            ),
            MoreItemModel(
                id: .logout,
                title: "logout_title".localized,
                imageName: MoreSectionsImages.logout.rawValue,
                showChevron: false,
                titleColor: .red,
                action: logout
            )
        ]
        
        return [
            AnyMoreSection(title: "", items: mainItems),
        ]
    }
}

enum MoreSectionsImages: String {
    case profile = "profile"
    case settings = "settings"
    case terms = "terms"
    case aboutApp = "aboutApp"
    case policy = "policy"
    case logout = "logout"
    case login = "login"
    case editPhone = "changePhone"
    case changeNotification = "changeNotification"
    case deleteAccount = "deleteAccount"
    case editProfile = "editUser"
    case changeLanguage = "changeLanguage"
}


extension MoreSectionsFactory {

    static func guestSections(
        navigate: @escaping (MoreRowID) -> Void
    ) -> [AnyMoreSection] {

        let items: [MoreItemModel] = [
            MoreItemModel(
                id: .changeLanguage,
                title: "change_language_title".localized,
                imageName: MoreSectionsImages.changeLanguage.rawValue,
                showChevron: true,
                titleColor: .black,
                action: { navigate(.changeLanguage) }
            ),
            MoreItemModel(
                id: .terms,
                title: "terms_and_conditions_title".localized,
                imageName: MoreSectionsImages.terms.rawValue,
                showChevron: true,
                titleColor: .black,
                action: { navigate(.terms) }
            ),
            MoreItemModel(
                id: .about,
                title: "about_app_title".localized,
                imageName: MoreSectionsImages.aboutApp.rawValue,
                showChevron: true,
                titleColor: .black,
                action: { navigate(.about) }
            ),
            MoreItemModel(
                id: .privacy,
                title: "privacy_title".localized,
                imageName: MoreSectionsImages.policy.rawValue,
                showChevron: true,
                titleColor: .black,
                action: { navigate(.privacy) }
            ),
            MoreItemModel(
                id: .login,
                title: "login_title".localized,
                imageName: MoreSectionsImages.login.rawValue,
                showChevron: false,
                titleColor: .primaryMain,
                action: { navigate(.login) }
            )
        ]

        return [
            AnyMoreSection(title: "", items: items)
        ]
    }
}
