//
//  AdModel.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 10/06/2026
//

import Foundation

struct AdModel: Identifiable, Codable, Hashable {
    var id: Int
    var title: String
    var price: Double
    var date: String
    var sellerName: String
    var image: String
    var isFeatured: Bool
}

enum AdsLayoutStyle: CaseIterable {
    case list
    case grid
    case map

    var icon: String {
        switch self {
        case .list: return "rectangle.grid.1x2"
        case .grid: return "square.grid.2x2"
        case .map:  return "mappin.and.ellipse"
        }
    }
}
