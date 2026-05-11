//
//  ProfileRoute.swift
//  CTF
//
//  Created by Ahmed Ramadan on 17/11/2025.
//

// MoreRoute.swift

enum MoreCoordinatorRoute: Hashable {
    case profile
    case settings
    case about
    case privacy
    case verfiyOldPhoneNumber
    case verifyNewPhoneNumber(phone: String, countryCode: String)
    case changePhoneNumber
    case editProfile
    // TODO: Add project-specific routes here
}
