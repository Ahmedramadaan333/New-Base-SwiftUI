//
//  TripsPagination.swift
//  CTF
//
//  Created by Ahmed Ramadan on 10/12/2025.
//


// MARK: - Pagination

struct Pagination: Codable {
    var totalItems: Int?
    var countItems: Int?
    var perPage: Int?
    var totalPages: Int?
    var currentPage: Int?
    var nextPageUrl: String?
    var prevPageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case totalItems = "total_items"
        case countItems = "count_items"
        case perPage = "per_page"
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextPageUrl = "next_page_url"
        case prevPageUrl = "perv_page_url"
    }
}
