//
//  InfoScreenKind.swift
//  CTF
//
//  Created by Ahmed Ramadan on 27/11/2025.
//


import Foundation

enum InfoScreenKind {
    case aboutApp
    case terms
    case privacy
}

extension InfoScreenKind {
    
    var titleKey: String {
        switch self {
        case .aboutApp:
            return "about_app_title".localized
        case .terms:
            return "terms_and_conditions_title".localized
        case .privacy:
            return "privacy_title".localized
        }
    }
    
    var endpoint: Endpoint<BaseResponse<String>> {
        switch self {
        case .aboutApp:
            return MoreEndPoint.getAboutApp()
        case .terms:
            return MoreEndPoint.getTerms()
        case .privacy:
            return MoreEndPoint.getPrivacy()
        }
    }
}
