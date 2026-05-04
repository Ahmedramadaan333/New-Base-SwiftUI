//
//  LocationPoint.swift
//  CTF
//
//  Created by Ahmed Ramadan on 15/02/2026.
//



import Foundation

struct LocationPoint: Codable, Hashable {
    var address: String?
    var lat: Double?
    var lng: Double?
    var placeId: String?

    init(address: String? = nil, lat: Double? = nil, lng: Double? = nil, placeId: String? = nil) {
        self.address = address
        self.lat = lat
        self.lng = lng
        self.placeId = placeId
    }
}
