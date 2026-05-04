//
//  MoreModalRoute.swift
//  CTF
//
//  Created by Ahmed Ramadan on 03/12/2025.
//

import Foundation
enum MoreModalRoute: Identifiable {
    case changeLanguage
    // TODO: Add project-specific modal routes here

    var id: String {
        String(describing: self)
    }
}
