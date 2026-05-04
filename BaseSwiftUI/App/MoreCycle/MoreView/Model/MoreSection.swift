//
//  MoreSection.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 31/07/2025.
//
//

import SwiftUI

enum MoreRowID: Hashable {
    case settings
    case terms
    case about
    case privacy
    case logout
    case changeLanguage
    case login
    // TODO: Add project-specific row IDs here
}

struct MoreItemModel: Identifiable {
    let id: MoreRowID
    let title: String
    let imageName: String
    let showChevron: Bool
    let titleColor: Color
    let action: () -> Void

    var stringId: String { "\(id)" }
}

struct AnyMoreSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [MoreItemModel]
}
