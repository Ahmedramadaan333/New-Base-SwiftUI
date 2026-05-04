//
//  KeyValueItem.swift
//  CTF
//
//  Created by Ahmed Ramadan on 22/12/2025.
//


import Foundation

struct KeyValueItem: Identifiable, Equatable {
    var id = UUID()
    var key: String
    var value: String
}

