//
//  HomeSection.swift
//  CTF
//
//  Created by Ahmed Ramadan on 08/12/2025.
//


import Foundation

struct HomeData: Codable {
    var images: [ImageModel]?
    var categories: [CategoryModel]?
}

struct ImageModel: Identifiable, Codable, Hashable {
    var id: Int?
    var image: String?
    
}

struct CategoryModel: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var image: String
}
