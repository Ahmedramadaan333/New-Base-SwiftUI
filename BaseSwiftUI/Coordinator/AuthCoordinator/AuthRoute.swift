//
//  AuthRoute.swift
//  CTF
//
//  Created by Ahmed Ramadan on 17/11/2025.
//


enum AuthRoute: Hashable {
    case verification(phone: String, countryCode: String)
    case completeRegisterData(phone: String, countryCode: String)
}
